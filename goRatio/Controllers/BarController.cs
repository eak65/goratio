using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Web.Http;
using goRatio.Models;
using Newtonsoft.Json.Linq;
using Newtonsoft.Json;
namespace goRatio.Controllers
{
    public class BarController : ApiController
    {
  

        public HttpResponseMessage GetBarsAroundMe(int userId)
        {
            int distance = 5000;
            using (var db = new goRatioModelContainer())
            {

            User user=    db.Users.Find(userId);
                if(user ==null)
                {
                    return Request.CreateResponse(HttpStatusCode.NotFound);
                }
    
                   IList<Bar>bars = db.Bars.Where(loc => loc.Location.Distance(user.Location) < distance).OrderBy(loc => loc.Location.Distance(user.Location)).ToList();
                   IList<BarDTO> barsDTO = new List<BarDTO>();
                foreach(Bar b in bars)
                    {
                        barsDTO.Add(new BarDTO(b));
                    }

                JArray barsObjects = JArray.Parse(JsonConvert.SerializeObject(barsDTO));
                return Request.CreateResponse<JArray>(HttpStatusCode.OK, barsObjects);
            }


        }




    }
}
