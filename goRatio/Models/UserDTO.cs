using System;
using System.Collections.Generic;
using System.Linq;
using System.Runtime.Serialization;
using System.Web;

namespace goRatio.Models
{
    public class UserDTO
    {
        public UserDTO(User user)
        {
            this.Id = user.Id;
            this.Location = user.Location;
            this.DeviceToken = user.DeviceToken;
            this.Gender = user.Gender;
            this.DeviceType = user.DeviceType;
            this.deviceForeground = user.deviceForeground;
            this.DUID = user.DUID;
        }
        public int Id { get; set; }
        public System.Data.Entity.Spatial.DbGeography Location { get; set; }
        public string DeviceToken { get; set; }
        public string Gender { get; set; }
        public string DeviceType { get; set; }
        public string DUID { get; set; }

        public bool deviceForeground { get; set; }
    }
    public class BarDTO 
    {
        public BarDTO() { }
        public BarDTO(Bar bar)
        {
            this.Id = bar.Id;
            this.Name = bar.Name;
            this.Location = bar.Location;
            this.MaleCount = bar.MaleCount;
            this.FemaleCount = bar.FemaleCount;
            this.Vicinity = bar.Vicinity;
            this.Rating = bar.Rating;
        }
        public int Id { get; set; }
        public string Rating { get; set; }
        public string Name { get; set; }
        public string Vicinity { get; set; }
        public System.Data.Entity.Spatial.DbGeography Location { get; set; }
        public int MaleCount { get; set; }
        public int FemaleCount { get; set; }
    }
    [DataContract]
       public class GoogleResultDTO
    {

          [DataMember]
        public IList<GoogleBarDTO>results;
    }
    public class GoogleBarDTO
    {

        public GoogleGeometry geometry {get;set;}
        public string icon { get; set; }
        public string place_id { get; set; }
        public string name { get; set; }
        public string rating { get; set; }
        public string reference { get; set; }
        public string vicinity { get; set; }

    }
    public class GoogleGeometry
    {
        public GoogleLocation location {get;set;}
    }
    public class GoogleLocation
    {
        public string lat { get; set; }
        public string lng { get; set; }
    }
}