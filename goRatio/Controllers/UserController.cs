using goRatio.Models;
using Newtonsoft.Json.Linq;
using System;
using System.Collections.Generic;
using System.Data.Entity.Spatial;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Web.Http;

namespace goRatio.Controllers
{
    public class UserController : ApiController
    {


        public HttpResponseMessage PostCreateUser(JObject deviceObject)
        {
            string DUID = deviceObject["DUID"].ToObject<string>();
            int gender = deviceObject["gender"].ToObject<Int32>();
            string location = deviceObject["location"].ToObject<string>();
            using (var db = new goRatioModelContainer())
            {
                User user = db.Users.Where(u => u.DUID.Equals(DUID)).FirstOrDefault();
                if (user == null)
                {

                    user = new User(gender, location, DUID);
                    db.Users.Add(user);
                    db.SaveChanges();
                }

                UserDTO userDTO = new UserDTO(user);

                return Request.CreateResponse<UserDTO>(HttpStatusCode.OK, userDTO);
            }

        }


        public HttpResponseMessage PutSetting(JObject deviceObject)
        {
            Int32 userId = deviceObject["userId"].ToObject<Int32>();
            Int32 gender = deviceObject["gender"].ToObject<Int32>();
            using (var db = new goRatioModelContainer())
            {
                User user = db.Users.Find(userId);
                if (user == null)
                {

                    return Request.CreateResponse(HttpStatusCode.NotFound);
                }

                if(gender == 1 )
                {
                    user.Gender = "f";
                }
                else
                {
                    user.Gender = "m";
                }
                return Request.CreateResponse(HttpStatusCode.OK);
            }

        }
        public HttpResponseMessage GetUser(string DUID)

     {
            
            using (var db = new goRatioModelContainer())
            {
                User user = db.Users.Where(u => u.DUID.Equals(DUID)).FirstOrDefault();
                if (user == null)
                {
                    return Request.CreateResponse(HttpStatusCode.OK);

                }

                UserDTO userDTO = new UserDTO(user);

                return Request.CreateResponse<UserDTO>(HttpStatusCode.Accepted, userDTO);
            }

        }
    }
}
