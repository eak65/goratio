using Newtonsoft.Json.Linq;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Web.Http;
using goRatio.Models;
using System.Data.Entity.Spatial;
using System.Runtime.Serialization.Json;
using System.IO;

namespace goRatio.Controllers
{
    public class LocationController : ApiController
    {
        public  void updateBarsExisting(goRatioModelContainer db,User user)
        {
            DbGeography location = user.Location;
            int distance=500;
          
             Bar bar=db.Bars.Where(b => b.Location.Distance(location) < distance).FirstOrDefault();
          
             if (bar == null)
             {
             this.searchForBars(location);
                 if (user.Bar != null)
                 {
                     if (user.Gender.Equals("m"))
                     {
                         user.Bar.MaleCount--;
                     }
                     else
                     {
                         user.Bar.FemaleCount--;
                     }
                     user.Bar.Users.Remove(user);
                     user.Bar = null;
                 }
             }
                    if(user.Bar!=null) // had a bar before need to recheck it
                   {
                      if( !(user.Bar.Location.Distance(location)<25))
                      {
                          if (user.Gender.Equals("m"))
                          {
                              user.Bar.MaleCount--;
                          }
                          else
                          {
                              user.Bar.FemaleCount--;
                          }
                          user.Bar.Users.Remove(user);
                                                    user.Bar = null;

                      }
                   }
                    if(( bar!=null &&bar.Location.Distance(location)<25) && (user.Bar==null||(user.Bar!=null&&bar.Id != user.Bar.Id ))) // check new bar
                   {
                        
                       // check to see if user has a bar
                       bar.Users.Add(user);
                       if(user.Gender.Equals("m"))
                       {
                           bar.MaleCount++;
                       }else
                       {
                           bar.FemaleCount++;
                       }
                   }
                    db.SaveChanges();
            
               
        }
        public async void searchForBars(DbGeography location)
        {
          
            var client = new HttpClient();
            string key = "AIzaSyAVV2CsPEqZk8KJ1LbDf5wXMuNP81I0-10";
            var uri = new Uri("https://maps.googleapis.com/maps/api/place/nearbysearch/json?location=" + location.Latitude + "," + location.Longitude + "&radius=" + 200 + "&types=bar&key=" + key);
            GoogleResultDTO feed = null;
            using (Stream respStream = await client.GetStreamAsync(uri))
            {
                DataContractJsonSerializer ser = new DataContractJsonSerializer(typeof(GoogleResultDTO));
                feed = (GoogleResultDTO)ser.ReadObject(respStream);
                   
            }
            if (feed != null)
            {
                using (var db = new goRatioModelContainer())
                {
                    foreach (GoogleBarDTO gBar in feed.results)
                    {
                        Bar tempB = db.Bars.Where(gb => gb.PlaceId.Equals(gBar.place_id)).FirstOrDefault();
                        if (tempB==null)
                        {
                            db.Bars.Add(new Bar(gBar));
                            
                        }
                    }
                    db.SaveChanges();
                }
            }
          //  return Request.CreateResponse(HttpStatusCode.NotImplemented);
    
        }
        public HttpResponseMessage PutUpdateLocation(JObject locationObject)
        {
         string location=   locationObject["location"].ToObject<string>();
            int userId = locationObject["userId"].ToObject<Int32>();
            if (location.Equals("POINT(0.000000 0.000000)"))
            {
                return Request.CreateResponse(HttpStatusCode.NoContent);
            }
            using (var db = new goRatioModelContainer())
            {
                User user=  db.Users.Find(userId);
                if(user==null)
                {
                    return Request.CreateResponse(HttpStatusCode.NotFound);
                }
              user.Location = DbGeography.FromText(location);
              user.LastUpdatedLocation = DateTime.UtcNow;
              this.updateBarsExisting(db,user);
            
              db.SaveChanges();
              return Request.CreateResponse(HttpStatusCode.OK);
            }

        }
    }
}
