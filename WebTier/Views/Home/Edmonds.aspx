<%@ Page Language="C#" MasterPageFile="~/Views/Shared/Site.Master" Inherits="System.Web.Mvc.ViewPage" %>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <script type="text/javascript" src="../Scripts/JSONHelp.js"></script>
    <script type="text/javascript">

    $(function () {
    });

    function ShowResponse(JSONdata) {
        $("#results").html($.printJSONToHTML(JSONdata, 0));
    };

    function SearchDealersLoc(zipcode) {
        var requestData = {
            'api_key': '<%:ViewData["EdmundsDealerAPIKey"]%>',
            'zipcode': zipcode,
            'fmt': 'json'
        };

        $.getJSON('<%:ViewData["EdmundsDealerUri"]%>?callback=?', requestData, ShowResponse);
    };

    function SearchDealersLocMake(zipcode, make) {
        var requestData = {
            'api_key': '<%:ViewData["EdmundsDealerAPIKey"]%>',
            'zipcode': zipcode,
	    'make' : make,
            'fmt': 'json'
        };

        $.getJSON('<%:ViewData["EdmundsDealerUri"]%>?callback=?', requestData, ShowResponse);
    };


    </script>
    <p>
        This sample shows how to access information in the Edmunds.com API.
        The developer site is <a href="http://developer.edmunds.com/">here</a>.
        Terms of usage are <a href="http://developer.edmunds.com/Api_terms_of_use">here</a>. 
     </p>

     <p>
     There are three basic areas of this API ---- Vehicle information (essentially metadata about US vehicle make, model, style, etc), Inventory (by VIN corresponding to Edmunds.com inventory only) and Dealer information (by location). The last is most valuable from a local service POV and so it is the only one prototyped here.
     </p>

     <div id="Edmunds Dealer API" style="display:block">
                <script type="text/javascript">
                    function GetMake(form) {
                        var i;
                        for (i = 0; i < form.Make.length; i++) {
                            if (form.Make[i].checked) {
			        return form.Make[i].value;
                            }
                        }
                        return null;
                    };
		 </script>
     <h2> Dealer API </h2>
     <table>
        <thead>
            <tr>
            <td>Search by location</td>
            <td>Search by location and make</td>
            </tr>
        </thead>
        <tbody>
        <tr>
            <td>
                <form action="Edmonds.aspx">
                    Zipcode : <input type="text" name="Zipcode" value="98008"/> <br />
                    <input type="button" value="Search" onclick="SearchDealersLoc(this.form.Zipcode.value);" />
                </form>                                 
            </td>
            <td>
                <form action="Edmonds.aspx">
                    Zipcode : <input type="text" name="Zipcode" value="98008"/> <br />

                    <input type="radio" name="Make" value="Volkswagen"/> Volkswagen <br />
                    <input type="radio" name="Make" value="Subaru"/> Subaru <br />
                    <input type="radio" name="Make" value="Toyota"/> Toyota <br />
                    <input type="radio" name="Make" value="Honda"/> Honda <br />

                    <input type="button" value="<Filter Not Working>" onclick="SearchDealersLocMake(this.form.Zipcode.value, GetMake(this.form));" />

                </form>                                 
            </td>
        </tr>
        </tbody>
     </table>
     </div>

     <p>
     <h2>Results</h2>
     </p>
     <div id="results"></div>
    
    
</asp:Content>
