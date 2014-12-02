using Newtonsoft.Json.Linq;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Web.Http;
using goRatio.Models;
using System.Data.Entity.Spatial;
namespace goRatio.Controllers
{
    public class DeviceController : ApiController
    {

      
        public HttpResponseMessage GetUser(int userId)
        {

            using (var db = new goRatioModelContainer())
            {
                User user = db.Users.Find(userId);
                if (user == null)
                {
                    return Request.CreateResponse(HttpStatusCode.NotFound);

                }
                
             
                UserDTO userDTO = new UserDTO(user);

                return Request.CreateResponse<UserDTO>(HttpStatusCode.OK, userDTO);
            }

        }
    }
}
