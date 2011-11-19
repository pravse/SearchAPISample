<%@ Page Language="C#" MasterPageFile="~/Views/Shared/Site.Master" Inherits="System.Web.Mvc.ViewPage" %>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <script type="text/javascript" src="../Scripts/JSONHelp.js"></script>
    <script type="text/javascript" src="http://oauth.googlecode.com/svn/code/javascript/oauth.js"></script>
    <script type="text/javascript" src="http://oauth.googlecode.com/svn/code/javascript/sha1.js"></script>
    <script type="text/javascript">

        $(function () {
        });

        function ShowResponse(JSONdata) {
            // alert($.printableJSON(JSONdata, 0));
            $("#results").html($.printJSONToHTML(JSONdata, 0));
        };

        var auth = {
           //  
           // Update with your auth tokens.
           //  
           consumerKey: '<%:ViewData["YelpConsumerKey"]%>',
           consumerSecret: '<%:ViewData["YelpConsumerSecret"]%>',
           accessToken: '<%:ViewData["YelpToken"]%>',
           accessTokenSecret: '<%:ViewData["YelpTokenSecret"]%>',
           serviceProvider: {
               signatureMethod: "HMAC-SHA1"
           }
       };

       var accessor = {
           consumerSecret: auth.consumerSecret,
           tokenSecret: auth.accessTokenSecret
       };
        

        function SearchYelp(pushParamFunc) {
            parameters = [];
            pushParamFunc(parameters);
            parameters.push(['callback', 'cb']);
            parameters.push(['oauth_consumer_key', auth.consumerKey]);
            parameters.push(['oauth_consumer_secret', auth.consumerSecret]);
            parameters.push(['oauth_token', auth.accessToken]);
            parameters.push(['oauth_signature_method', 'HMAC-SHA1']);

            var message = {
                'action': '<%:ViewData["YelpAPIUri"]%>',
                'method': 'GET',
                'parameters': parameters
            };

            OAuth.setTimestampAndNonce(message);
            OAuth.SignatureMethod.sign(message, accessor);

            var parameterMap = OAuth.getParameterMap(message.parameters);
            // console.log(parameterMap);
            $.ajax({
                'url': message.action,
                'data': parameterMap,
                'dataType': 'jsonp',
                'jsonpCallback': 'cb',
                'success': function (data, textStats, XMLHttpRequest) {
                    // console.log(data);
                    ShowResponse(data);
                }
            });
        };

        function SearchByLoc(loc, categories, searchTerm) {
            SearchYelp(function (parameters) {
                if (null != searchTerm) {
                    parameters.push(['term', htmlEncode(searchTerm)]);
                }
                if (null != categories) {
                    parameters.push(['category_filter', htmlEncode(categories)]);
                }
                if (null != loc) {
                    parameters.push(['location', htmlEncode(loc)]);
                }
            });
        };

        function SearchByLatLong(lat, long, categories, searchTerm) {
            SearchYelp(function (parameters) {
                if (null != searchTerm) {
                    parameters.push(['term', htmlEncode(searchTerm)]);
                }
                if (null != categories) {
                    parameters.push(['category_filter', htmlEncode(categories)]);
                }
                if ((null != lat) && (null != long)) {
                    parameters.push(['ll', htmlEncode(lat) + ',' + htmlEncode(long)]);
                }
             });
        };

        function EnableSearchAPI() {
            $("#SearchAPI")[0].style.display = "";
            $("#BusinessAPI")[0].style.display = "none";
        };

        function EnableBusinessAPI() {
            $("#SearchAPI")[0].style.display = "none";
            $("#BusinessAPI")[0].style.display = "";
        };


    </script>

    <p>
        This sample shows how to access information in the Yelp API. 
        The developer site is <a href="http://www.yelp.com/developers">here</a>.
        Terms of usage are <a href="http://www.yelp.com/developers/getting_started/api_terms">here</a>. 
     </p>
     <p>
        The app may use Yelp data to provide users with detailed information regarding a particular location, and/or reviews for a business.
        The app cannot cache, store, analyze or otherwise use Yelp content except for real-time consumer-driven use. 
        The usage limit is 100 API requests per day, which may be raised to 10,000 per day after review.
     </p>
     <p>
     Of particular interest, Yelp provides a detailed <a href="http://www.yelp.com/developers/documentation/category_list">category hierarchy</a>. A small subset of these categories are used in the example below.
     </p>
     <p>
        <button id="SearchButton" onclick="EnableSearchAPI();">Search API</button>
        <button id="BusinessButton" onclick="EnableBusinessAPI();">Business API</button>
     </p>
     <div id="SearchAPI" style="display:block">
                <script type="text/javascript">
                    function GetLoc(form) {
                        var i;
                        for (i = 0; i < form.Locations.length; i++) {
                            if (form.Locations[i].checked) {
                                break;
                            }
                        }
                        return form.Locations[i].value;
                    };
                    // yelp types/categories can be multi-selected
                    function GetType(form) {
                        var returnTypes = null;
                        var i;
                        for (i = 0; i < form.Types.length; i++) {
                            if (form.Types[i].checked) {
                                if (null == returnTypes) {
                                    returnTypes = form.Types[i].value;
                                }
                                else {
                                    returnTypes = returnTypes + ',' + form.Types[i].value;
                                }
                            }
                        }
                        return returnTypes;
                    };
                </script>
     <h2> Search API </h2>
     <table>
        <thead>
            <tr>
            <td>Search by location</td>
            <td>Search by lat/long</td>
            </tr>
        </thead>
        <tbody>
        <tr>
            <td>
                <form action="Yelp.aspx">
                    <input type="radio" name="Locations" value="Redmond, WA"/> Redmond, WA<br />
                    <input type="radio" name="Locations" value="98008" checked/> 98008 <br />
                    <input type="radio" name="Locations" value="1 Microsoft Way, Redmond, WA"/>1 Microsoft Way, Redmond, WA <br />
                    <hr />
                    <input type="checkbox" name="Types" value="homeservices"/> Home Services <br />
                    <input type="checkbox" name="Types" value="localservices"/> Local Services <br />
                    <input type="checkbox" name="Types" value="professional" checked/> Professional Services <br />
                    <input type="checkbox" name="Types" value="restaurants"/> Restaurants <br />
                    <input type="checkbox" name="Types" value="realestate"/> Real Estate <br />
                    <input type="checkbox" name="Types" value="homeandgarden"/> Home and Garden<br />
                    <input type="checkbox" name="Types" value="health"/> Health<br />
                    <input type="checkbox" name=    "Types" value="auto"/> Automotive <br />

                    Search term : <input type="text" name="SearchTerm" value=""/> <br />
                    
                    <input type="button" value="Search" onclick="SearchByLoc(GetLoc(this.form), GetType(this.form), this.form.SearchTerm.value);" />
                </form> 
            </td>
            <td>
                <form action="CityGrid.aspx">
                    Lat : <input type="text" name="Latitude" value="47.607551"/> <br />
                    Long : <input type="text" name="Longitude" value="-122.117597"/> <br />
                    
                    <input type="checkbox" name="Types" value="homeservices"/> Home Services <br />
                    <input type="checkbox" name="Types" value="localservices"/> Local Services <br />
                    <input type="checkbox" name="Types" value="professional" checked/> Professional Services <br />
                    <input type="checkbox" name="Types" value="restaurants"/> Restaurants <br />
                    <input type="checkbox" name="Types" value="realestate"/> Real Estate <br />
                    <input type="checkbox" name="Types" value="homeandgarden"/> Home and Garden<br />
                    <input type="checkbox" name="Types" value="health"/> Health<br />
                    <input type="checkbox" name="Types" value="auto"/> Automotive <br />

                    Search term : <input type="text" name="SearchTerm" value=""/> <br />
                                        
                    <input type="button" value="Search" onclick="SearchByLatLong(this.form.Latitude.value, this.form.Longitude.value, GetType(this.form), this.form.SearchTerm.value);" />
                </form>                                 
            </td>
          
        </tr>
        </tbody>
     </table>
     </div>
     <div id="BusinessAPI" style="display:none">
     <h2> Business API </h2>
     TODO. Given a business id (from a search result), the business API provides details of the business, reviews, and ratings.
     </div>

     <p>
     <h2>Results</h2>
     </p>
     <div id="results"></div>
    
</asp:Content>
