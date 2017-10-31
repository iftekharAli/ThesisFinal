<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="ShowInChart.aspx.cs" Inherits="CustomerStaApp.ShowInChart" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.4.0/Chart.min.js"></script>
    <link href="Content/font-awesome.min.css" rel="stylesheet" />

    <div class="row">
        <div class="col-md-8 col-sm-8 col-lg-8 col-md-offset-2 col-lg-offset-2 col-sm-offset-2 text-center">
            <label class="radio-inline">
                <input type="radio" value="region" name="chartType">Region wise
            </label>
            <label class="radio-inline">
                <input type="radio" value="age" name="chartType">Age
            </label>
        </div>
    </div>
    <br />
    <br />
    <div class="row">

        <div class="col-md-12 col-sm-12 col-lg-12 form-inline text-center">
            <div class="form-group">
                <label for="txtRecency">Recency:</label>
                <input id="txtRecency" type="text" class="form-control" placeholder="Recency" />
            </div>
            <div class="form-group">
                <label for="txtFrequency">Frequency:</label>
                <input id="txtFrequency" type="text" class="form-control" placeholder="Recency" />

            </div>
            <div class="form-group">
                <label for="txtMonetary">Monetary:</label>
                <input id="txtMonetary" type="text" class="form-control" placeholder="Recency" />

            </div>
            <button class="btn btn-default" onclick="return getChartTitleList()">Get Title List</button>
        </div>
    </div>
    <div class="row" id="chartConfig" style="display: none">
        <div class="col-md-12">
            <div class="checkbox" id="dvCheckBoxListControl"></div>

        </div>
        <div class="col-md-12">
            <button class="btn btn-default" onclick="return getChartData()">Plot Chart</button>
            <span id="spanLOding"><i class="fa fa-spinner fa-spin" aria-hidden="true" style="font-size: 24px"></i></span>
        </div>
    </div>

    <br />
    <br />
    <div class="row">
        <div id="plotChart">
        </div>
    </div>


    <script src="Scripts/ChartJs/AppChart.js?v=1"></script>

    <script>

        var array = [];
        var Monetary = '';
        var Recency = '';
        var Frequency = '';
        var chartTpe = '';

        $(document).ready(function () {
            $('#spanLOding').hide();

        });

        function intializeValue() {
            Monetary = $('#txtMonetary').val();
            Recency = $('#txtRecency').val();
            Frequency = $('#txtFrequency').val();
            chartTpe = $("input:radio[name=chartType]:checked").val();
            console.log(chartTpe);
        }



        function getChartTitleList() {

            intializeValue();

            console.log(Monetary);
            console.log(Recency);
            console.log(Frequency);

            $.ajax({
                url: "Handler/GetChartRegionNamehandler.ashx?Recency=" + Recency + "&Frequency=" + Frequency + "&Monetary=" + Monetary + "&chartTpe=" + chartTpe,
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                responseType: "json",
                success: onComplete
            });

            function onComplete(registration) {
                console.log(registration);
                CreateCheckBoxList(registration);
            }

            return false;
        }

        function CreateCheckBoxList(checkboxlistItems) {
            var table = $('<table class="table table-bordered table-condensed"></table>');
            var row = $('<tr></tr>');
            var counter = 0;
            $(checkboxlistItems).each(function () {
                var td = $('<td></td>');

                var label = $('<label class="checkbox-inline"> </label>').attr({
                    for: 'chklistitem' + counter++
                }).text(this.Title);

                var chec = $('<input>').attr({
                    type: 'checkbox',
                    name: 'chklistitem',
                    value: this.Value,
                    id: 'chklistitem' + counter


                });

                label.prepend(chec);
                td.append(label);
                row.append(td);
            });
            table.append(row);

            $('#dvCheckBoxListControl').empty();

            $('#dvCheckBoxListControl').append(table);
            $('#chartConfig').css('display', 'block');

            //$(document).on('change', '[type=checkbox]', function () {
            //    array.push();
            //}); 

            $('label').click(function () {
                var checked = $('input', this).is(':checked');
                $('span', this).text(checked ? 'Off' : 'On');
            });


            $('#chartConfig :checkbox').click(function () {

                // array.push($(this).parent().text());

                var idx = $.inArray($(this).parent().text(), array);
                if (idx == -1) {
                    array.push($(this).parent().text());
                } else {
                    array.splice(idx, 1);
                }
                console.log(array);
            });


        }
        function getChartData() {
            //$.ajax({
            //    url: "Handler/ChartData.ashx",
            //    contentType: "application/json; charset=utf-8",
            //    dataType: "json",
            //    responseType: "json",
            //    success: function (data) { alert('data: ' + data); }
            //});
            $('#spanLOding').show();
            intializeValue();
            console.log('click');
            $.ajax({
                url: "Handler/ChartData.ashx?Recency=" + Recency + "&Frequency=" + Frequency + "&Monetary=" + Monetary + "&chartTpe=" + chartTpe,
                type: 'POST',
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                responseType: "json",
                data: JSON.stringify(array),
                success: chartData,
                error: function () {
                    $('#spanLOding').hide();
                    $('#plotChart').empty();
                }
            });
            function chartData(data) {

                $('#spanLOding').hide();


                $('#plotChart').empty();
                //  var obj = jQuery.parseJSON(data);
                $.each(data, function () {
                    console.log(this.Title);

                    var $container = $("#plotChart");
                    var id = $container.children().length + 1;
                    var chartid = 'chart' + id;
                    var rowDiv = '';
                    var closeDiv = '';

                    $container.append('<div id="chartdiv' + id + '" class="col-md-8 col-lg-8 col-sm-8 col-md-offset-2 col-lg-offset-2 col-sm-offset-2"> <canvas id="chart' + id + '" width="90%"></canvas></div><br/><br/>');

                    plotChart(chartid, this);
                });


            }
            return false;
        };
    </script>
</asp:Content>
