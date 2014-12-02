using System;
using System.Collections.Generic;
using System.Data.Entity.Spatial;
using System.Linq;
using System.Web;

namespace goRatio.Models
{
    public partial class User
    {
        public User()
        { }
        public User(int gender, string location, string DUID)
        {
            this.DeviceToken = "";
            this.DeviceType = "";
            string gen;
            if (gender == 1)
            {
                gen = "f";
            }
            else
            {
                gen = "m";
            }

            this.deviceForeground = false;

            this.Gender = gen;
            this.AllowPush = false;
            this.DUID = DUID;
            this.Location = DbGeography.FromText(location);
            this.LastUpdatedLocation = DateTime.UtcNow;
        }
    }
    public partial class Bar
    {
        public Bar (GoogleBarDTO gBar)
        {
            string locationPoint ="POINT("+gBar.geometry.location.lng+" "+gBar.geometry.location.lat+")";
            this.FemaleCount = 0;
            this.MaleCount = 0;
            this.Location = DbGeography.FromText(locationPoint);
            this.Name = gBar.name;
            this.Icon = gBar.icon;
            this.Reference = gBar.reference;
            this.Vicinity = gBar.vicinity;
            this.Rating = gBar.rating;
            if(this.Rating==null)
            {
                this.Rating ="-1";
            }
            this.PlaceId = gBar.place_id;


        }
    }
}