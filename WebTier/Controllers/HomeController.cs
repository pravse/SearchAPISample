using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using System.Configuration;

namespace WebTier.Controllers
{
    [HandleError]
    public class HomeController : Controller
    {
        public ActionResult Index()
        {
            ViewData["Title"] = "Home";
            ViewData["Header"] = "Sample Use of Search/Directory APIs";
            return View("Index");
        }


        public ActionResult Yahoo()
        {
            ViewData["Title"] = "Search/Directory APIs";
            ViewData["Header"] = "Yahoo Local Search APIs";

            return View("Yahoo");
        }

        public ActionResult Google()
        {
            ViewData["Title"] = "Search/Directory APIs";
            ViewData["Header"] = "Google Maps APIs";
            ViewData["Logo"]= "../Content/powered-by-google.png";
            ViewData["LogoAltText"] = "Google Logo";
            ViewData["GooglePlacesUri"] = "https://maps.googleapis.com/maps/api/place/search/json";
            ViewData["GooglePlacesKey"] = ConfigurationManager.AppSettings["GooglePlacesKey"];
            return View("Google");
        }

        public ActionResult Nokia()
        {
            ViewData["Title"] = "Search/Directory APIs";
            ViewData["Header"] = "Nokia Places APIs";
            ViewData["Logo"]= "../Content/Nokia-Logo.jpg";
            ViewData["LogoAltText"] = "Nokia Logo";
            return View("Nokia");
        }

        public ActionResult Bing()
        {
            ViewData["Title"] = "Search/Directory APIs";
            ViewData["Header"] = "Bing Phonebook APIs";
            ViewData["Logo"]= "../Content/bing-logo.png";
            ViewData["LogoAltText"] = "Bing Logo";
            ViewData["BingUri"] = "http://api.bing.net/json.aspx";
            ViewData["BingAppId"] = ConfigurationManager.AppSettings["BingAppId"];
            return View("Bing");
        }
        public ActionResult CityGrid()
        {
            ViewData["Title"] = "Search/Directory APIs";
            ViewData["Header"] = "CityGrid APIs";
            ViewData["Logo"]= "../Content/CityGrid_Media_Logo.png";
            ViewData["LogoAltText"] = "CityGrid Logo";
            ViewData["CityGridWhereUri"] = "http://api.citygridmedia.com/content/places/v2/search/where";
            ViewData["CityGridKey"] = ConfigurationManager.AppSettings["CityGridKey"];
            return View("CityGrid");
        }
        public ActionResult YellowPages()
        {
            ViewData["Title"] = "Search/Directory APIs";
            ViewData["Header"] = "Yellow Pages APIs";
            ViewData["Logo"]= "../Content/yp-logo.jpg";
            ViewData["LogoAltText"] = "YP Logo";
            ViewData["YPListingsUri"] = "http://api2.yp.com/listings/v1";
            ViewData["YPAPIKey"] = ConfigurationManager.AppSettings["YPAPIKey"];
            return View("YellowPages");
        }
        public ActionResult Yelp()
        {
            ViewData["Title"] = "Search/Directory APIs";
            ViewData["Header"] = "Yelp APIs";
            ViewData["Logo"] = "../Content/Powered_By_Yelp.png";
            ViewData["LogoAltText"] = "Yelp Logo";
            ViewData["YelpAPIUri"] = "http://api.yelp.com/v2/search";
            ViewData["YelpConsumerKey"] = ConfigurationManager.AppSettings["YelpConsumerKey"];
            ViewData["YelpConsumerSecret"] = ConfigurationManager.AppSettings["YelpConsumerSecret"];
            ViewData["YelpToken"] = ConfigurationManager.AppSettings["YelpToken"];
            ViewData["YelpTokenSecret"] = ConfigurationManager.AppSettings["YelpTokenSecret"];
            return View("Yelp");
        }
        public ActionResult FourSquare()
        {
            ViewData["Title"] = "Search/Directory APIs";
            ViewData["Header"] = "FourSquare Venue APIs";
            ViewData["Logo"] = "../Content/foursquare.png";
            ViewData["LogoAltText"] = "FourSquare Logo";
            ViewData["FourSquareVenuesUri"] = "https://api.foursquare.com/v2/venues";
            ViewData["FourSquareClientId"] = ConfigurationManager.AppSettings["FourSquareClientId"];
            ViewData["FourSquareClientSecret"] = ConfigurationManager.AppSettings["FourSquareClientSecret"];
            return View("FourSquare");
        }
        public ActionResult ThreeTaps()
        {
            ViewData["Title"] = "Search/Directory APIs";
            ViewData["Header"] = "3Taps (data aggregation) APIs";
            ViewData["Logo"] = "../Content/threetaps.jpg";
            ViewData["LogoAltText"] = "3Taps Logo";
            ViewData["3TapsKey"] = ConfigurationManager.AppSettings["3TapsKey"];
            return View("ThreeTaps");
        }
        public ActionResult Edmonds()
        {
            ViewData["Title"] = "Search/Directory APIs";
            ViewData["Header"] = "Edmonds (auto) APIs";
            ViewData["Logo"] = "../Content/Edmunds.png";
            ViewData["LogoAltText"] = "Edmunds Logo";
            ViewData["EdmundsDealerUri"] = "http://api.edmunds.com/v1/api/dealer";
            ViewData["EdmundsDealerAPIKey"] = ConfigurationManager.AppSettings["EdmundsDealerAPIKey"];
            return View("Edmonds");
        }

    }
}
