<%@ Page Language="C#" MasterPageFile="~/Views/Shared/Site.Master" Inherits="System.Web.Mvc.ViewPage" %>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <p>
        This sample shows how to access information in the Yahoo Local Search API.        
        The developer site is <a href="http://developer.yahoo.com/search/local/V3/localSearch.html">here</a>.
        Terms of usage are <a href="http://info.yahoo.com/guidelines/us/yahoo/ydn/ydn-3955.html">here</a>. 
     </p>

     <p>
     The Y! Local Search API seems very similar to the APIs from Google/Bing/Yelp. Unfortunately, Y! states very clearly that the API is not meant for commercial use of any kind. So I am not prototyping its use here.
     </p>

     <p> Y! does have another service called YQL (Yahoo Query Language) which is a query processing service across distributed web services that expose data. That is definitely worth looking into.
    
</asp:Content>
