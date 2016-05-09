<%@ Page Title="Home Page" Language="C#" MasterPageFile="~/Site.master" AutoEventWireup="true"
    CodeFile="Default.aspx.cs" Inherits="_Default" %>

<asp:Content ID="HeaderContent" runat="server" ContentPlaceHolderID="HeadContent">
</asp:Content>

<asp:Content ID="BodyContent" runat="server" ContentPlaceHolderID="MainContent">
<%--    <h2>
        Welcome to ASP.NET!
    </h2>
    <p>
        To learn more about ASP.NET visit <a href="http://www.asp.net" title="ASP.NET Website">www.asp.net</a>.
    </p>
    <p>
        You can also find <a href="http://go.microsoft.com/fwlink/?LinkID=152368&amp;clcid=0x409"
            title="MSDN ASP.NET Docs">documentation on ASP.NET at MSDN</a>.
    </p>--%>
        <script type="text/javascript" src="Scripts/jquery-1.11.3.min.js"></script>
        <script type="text/javascript" src="http://code.highcharts.com/highcharts.js"></script>

                <h4>Select the year to display pie chart:</h4>
    <br />
                <select id="ddlyear">
                    <option>Select the year </option>
                    <option>2010</option>
                    <option>2013</option>
                    <option>2014</option>
                </select>
                <button id="btnCreatePieChart">Show Population</button>
                <br />
                <div>
                    <div id="container" style="width: 1035px; height: 920px; padding-top:50px;">
                    
<%--                    <img src="Images/computer-see-peoples-dreams-660x433.jpg" alt="Smiley face" height="420" width="420">
                        <asp:LinkButton ID="LinkButton1" runat="server" onclick="LinkButton1_Click">Show text</asp:LinkButton>--%>

                    </div>

                          <asp:label id="Label1" runat="server"></asp:label>

                </div>


                <script type="text/javascript">
                function drawPieChart(seriesData) {

                    $('#container').highcharts({
                        chart: {
                            plotBackgroundColor: null,
                            plotBorderWidth: null,
                            plotShadow: false,
                            type: 'pie'
                        },
                        title: {
                            text: 'Top 50 Cities in the U.S. by Population and Rank'
                        },
                        tooltip: {
                            pointFormat: '{series.name}: <b>{point.percentage:.1f}%</b>'
                        },
                        plotOptions: {
                            pie: {
                                size: '70%',
                                allowPointSelect: true,
                                cursor: 'pointer',
                                dataLabels: {
                                    enabled: true,
                                    format: '<b>{point.name}</b>: {point.percentage:.1f} %',
                                    style: {
                                        color: (Highcharts.theme && Highcharts.theme.contrastTextColor) || 'black'
                                    }
                                }
                            }
                        },
                        series: [{
                            name: "Brands",
                            colorByPoint: true,
                            data: seriesData
                        }]
                    });
                }
                </script>

                <script type="text/javascript">

                    $("#btnCreatePieChart").on('click', function (e) {
                        var pData = [];
                        pData[0] = $("#ddlyear").val();

                        var jsonData = JSON.stringify({ pData: pData });

                        $.ajax({
                            type: "POST",
                            url: "WebService.asmx/getCityPopulation",
                            data: jsonData,
                            contentType: "application/json; charset=utf-8",
                            dataType: "json",
                            success: OnSuccess_,
                            error: OnErrorCall_
                        });

                        function OnSuccess_(response) {
                            var aData = response.d;
                            var arr = []

                            $.map(aData, function (item, index) {
                                var i = [item.city_name, item.population];
                                var obj = {};
                                obj.name = item.city_name;
                                obj.y = item.population;
                                arr.push(obj);
                            });
                            var myJsonString = JSON.stringify(arr);
                            var jsonArray = JSON.parse(JSON.stringify(arr));

                            drawPieChart(jsonArray);

                        }
                        function OnErrorCall_(response) {
                            alert("Whoops something went wrong!");
                        }
                        e.preventDefault();
                    });
                    
                </script>

</asp:Content>
