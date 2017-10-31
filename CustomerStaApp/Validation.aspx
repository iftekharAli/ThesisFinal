<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Validation.aspx.cs" Inherits="CustomerStaApp.Validation" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="container">
        <div class="row">
            <div class="col-md-8 col-sm-8 col-lg-8 col-md-offset-2 col-lg-offset-2 col-sm-offset-2 text-center">
                <label class="radio-inline">
                    <input type="radio" value="region" name="Title">Region wise
                </label>
                <label class="radio-inline">
                    <input type="radio" value="age" name="Title">Age
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
                    <input id="txtFrequency" type="text" class="form-control" placeholder="Frequency" />

                </div>
                <div class="form-group">
                    <label for="txtMonetary">Monetary:</label>
                    <input id="txtMonetary" type="text" class="form-control" placeholder="Monetary" />

                </div>

                <button class="btn btn-default" onclick="return getChartTitleList()">Get Title List</button>
            </div>
        </div>

        <div class="row" id="divTitle" style="display: none">
            <div class="col-md-12">
                <div class="checkbox" id="dvCheckBoxListControl"></div>

            </div>
            <div class="col-md-12 text-center" style="display: none" id="divSubNRating">
                <div class="form-inline ">
                    <div class="form-group">
                        <label for="txtRating">Rating:</label>
                        <input id="txtRating" type="text" class="form-control" placeholder="Rating" />

                    </div>

                    <span id="spanLOding"><i class="fa fa-spinner fa-spin" aria-hidden="true" style="font-size: 24px"></i></span>
                    <button class="btn btn-default btn-primary" onclick="return getData()">Submit</button>
                </div>



            </div>
        </div>

        <br />
        <br />

        <div class="col-md-12">
            <div>

                <!-- Nav tabs -->
                <ul class="nav nav-tabs" role="tablist">
                    <li role="presentation" class="active"><a href="#tab1" aria-controls="home" role="tab" data-toggle="tab">Tab1</a></li>
                    <li role="presentation"><a href="#tab2" aria-controls="profile" role="tab" data-toggle="tab">Tab2</a></li>
                    <li role="presentation"><a href="#tab3" aria-controls="profile" role="tab" data-toggle="tab">Tab3</a></li>

                </ul>

                <!-- Tab panes -->
                <div class="tab-content">

                    <div role="tabpanel" class="tab-pane active" id="tab1">


                        <div class="row">
                            <div class="col-md-12 col-sm-12 col-lg-12">
                                <button class="btn btn-primary" id="btnNextStep" onclick="return nextStep()"
                                    style="margin-bottom: 5px; margin-top: 4px; display: none">
                                    Next Step</button>
                            </div>
                            <div class="col-md-12 col-lg-12 col-sm-12">
                                <table id="tblValidData" class="table table-responsive table-striped table-bordered">
                                    <thead>
                                        <tr>
                                            <th>Region</th>
                                            <th>Product Category</th>
                                            <th>Rating</th>
                                            <th></th>
                                        </tr>
                                    </thead>
                                    <tbody></tbody>
                                </table>
                            </div>
                        </div>

                    </div>
                    <div role="tabpanel" class="tab-pane" id="tab2">

                        <div class="col-md-6 col-sm-6 col-lg-6">
                            <h2>Favourite</h2>
                            
                            <table id="tblNextStageValidData" class="table table-responsive table-striped table-bordered">
                                <thead>
                                    <tr>
                                        <th>Region</th>
                                        <th>Product</th>
                                        <th>Rating</th>
                                       
                                    </tr>
                                </thead>
                                <tbody></tbody>
                            </table>
                        </div>
                        <div class="col-md-6 col-sm-6 col-lg-6">
                            <h2>Non Favourite</h2>
                            
                            <table id="tblNextStageNonValidData" class="table table-responsive table-striped table-bordered">
                                <thead>
                                    <tr>
                                        <th>Region</th>
                                        <th>Product</th>
                                        <th>Rating</th>
                                     
                                    </tr>
                                </thead>
                                <tbody></tbody>
                            </table>
                        </div>


                    </div>
                    
                    <div role="tabpanel" class="tab-pane" id="tab3">

                        <div class="col-md-6 col-sm-6 col-lg-6">
                            <h2>Product Feedback</h2>
                            
                            <table id="tblApriorData" class="table table-responsive table-striped table-bordered">
                                <thead>
                                <tr>
                                    <th>Suggested Product</th>
                                    <th>Recommended Product</th>
                                 
                                   
                                       
                                </tr>
                                </thead>
                                <tbody></tbody>
                            </table>
                        </div>
                        

                    </div>

                </div>

            </div>
        </div>
        <%--<div class="row">
            <div class="col-md-12 col-lg-12 col-sm-12">
                <table id="tblValidData" class="table table-responsive table-striped table-bordered">
                    <thead>
                        <tr>
                            <th>Region</th>
                            <th>Product Category</th>
                            <th>Rating</th>
                        </tr>
                    </thead>
                    <tbody></tbody>
                </table>
            </div>
             <div class="col-md-6 col-lg-6 col-sm-6">
            <table id="tblnonValidData" class="table table-responsive table-striped table-bordered">
                <thead>
                    <tr>
                        <th>Region</th>
                        <th>Product</th>
                        <th>Rating</th>
                    </tr>
                </thead>
                <tbody></tbody>
            </table>
        </div>
        </div>--%>
    </div>
    <script>

        var array = [];
        var Monetary = '';
        var Recency = '';
        var Frequency = '';
        var DataType = '';
        var Rating = '';

        var nextStepPlotList = [];

        function intializeValue() {
            Monetary = $('#txtMonetary').val();
            Recency = $('#txtRecency').val();
            Frequency = $('#txtFrequency').val();
            Rating = $('#txtRating').val();
            DataType = $("input:radio[name=Title]:checked").val();
            //console.log(chartTpe);
        }
        function getChartTitleList() {

            intializeValue();
            console.log(Monetary);
            console.log(Recency);
            console.log(Frequency);

            $.ajax({
                url: "Handler/GetChartRegionNamehandler.ashx?Recency=" + Recency + "&Frequency=" + Frequency + "&Monetary=" + Monetary + "&chartTpe=" + DataType,
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
            $('#divTitle').css('display', 'block');

            //$(document).on('change', '[type=checkbox]', function () {
            //    console.log('push');
            //    array.push();
            //}); 

            $('label').click(function () {
                var checked = $('input', this).is(':checked');
                $('span', this).text(checked ? 'Off' : 'On');
            });


            $('#divTitle :checkbox').click(function () {

                // array.push($(this).parent().text());

                var idx = $.inArray($(this).parent().text(), array);
                if (idx == -1) {
                    array.push($(this).parent().text());
                } else {
                    array.splice(idx, 1);
                }

                console.log('array lenghth');
                console.log(array.length);
                if (array.length !== 0) {
                    $('#divSubNRating').css('display', 'block');
                } else {

                    $('#divSubNRating').hide();
                }

            });


        }

        function getData() {
            intializeValue();
            getValidData();
            //getNonValidData();
            return false;
        }

        function getValidData() {

            $.ajax({
                url: "Handler/ValidNNonValidHandler.ashx?Recency=" + Recency + "&Frequency=" + Frequency + "&Monetary=" + Monetary + "&DataType=" + DataType + "&Rating=" + Rating + "&Valid=1",
                type: 'POST',
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                responseType: "json",
                data: JSON.stringify(array),
                success: validDataSuccessResponce,
                error: function () {

                }
            });



            function validDataSuccessResponce(data) {
                console.log(data);
                var trHTML = '';

                $.each(data, function (j, item) {

                    $.each(item.Product, function (i, inner) {

                        //trHTML += '<tr><td>' + item.Title + '</td><td>' + inner.ProductName + '</td><td>' + inner.avg_rating + '</td><td><input type=text class=cr></td><td><input type=checkbox></td></tr>';
                        trHTML += '<tr><td>' + item.Title + '</td><td>' + inner.ProductName + '</td><td>' + inner.avg_rating + '</td><td><input type=checkbox></td></tr>';
                    });


                    //trHTML += '<tr><td>' + item.rank + '</td><td>' + item.content + '</td><td>' + item.UID + '</td></tr>';
                });
                $("#tblValidData > tbody").html("");
                $('#tblValidData').append(trHTML);
            }
        }


        function getNonValidData() {

            $.ajax({
                url: "Handler/ValidNNonValidHandler.ashx?Recency=" + Recency + "&Frequency=" + Frequency + "&Monetary=" + Monetary + "&DataType=" + DataType + "&Rating=" + Rating + "&Valid=0",
                type: 'POST',
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                responseType: "json",
                data: JSON.stringify(array),
                success: validDataSuccessResponce,
                error: function () {

                }
            });



            function validDataSuccessResponce(data) {
                console.log(data);
                var trHTML = '';

                $.each(data, function (i, item) {
                    //console.log('outer');
                    //console.log(this);
                    $.each(item.Product, function (i, inner) {
                        //console.log('inner');
                        //console.log(inner);
                        trHTML += '<tr><td>' + item.Title + '</td><td>' + inner.ProductName + '</td><td>' + inner.avg_rating + '</td></tr>';
                    });


                    //trHTML += '<tr><td>' + item.rank + '</td><td>' + item.content + '</td><td>' + item.UID + '</td></tr>';
                });

                $("#tblnonValidData > tbody").html("");
                $('#tblnonValidData').append(trHTML);
            }
        }

        $('#tblValidData').on('click', 'input[type="checkbox"]', function () {
            var tr = $(this).parent().parent();

            var title = $(tr).find("td").eq(0).html();
            var pCat = $(tr).find("td").eq(1).html();
            //  var cr = $(tr).find('.cr').val();
            //  var obj = { title: title, pCat: pCat, cr: cr };

            var idx = $.inArray(title + "_" + pCat, nextStepPlotList);
            if (idx === -1) {
                nextStepPlotList.push(title + "_" + pCat);
            } else {
                nextStepPlotList.splice(idx, 1);
            }

            if (nextStepPlotList.length !== 0) {
                $('#btnNextStep').css('display', 'block');
            } else {

                $('#btnNextStep').hide();
            }

        });

        function nextStep() {

            $.ajax({
                url: "Handler/GetProductValidNonvalidDataHandler.ashx?Recency=" + Recency + "&Frequency=" + Frequency + "&Monetary=" + Monetary + "&DataType=" + DataType + "&Rating=" + Rating,
                type: 'POST',
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                responseType: "json",
                data: JSON.stringify(nextStepPlotList),
                success: successResponce,
                error: function () {

                }
            });

            function successResponce(data) {
                console.log(data);
                var trSHTML = '';
                var trNSHTML = '';
                var trPriorHTML = '';
                $.each(data.valid, function () {
                    var d = data.valid;
                    trSHTML += '<tr><td>' + this.Title + '</td><td>' + this.Product + '</td><td>' + this.AVG_Rating + '</td></tr>';

                });
                $.each(data.nonvalid, function () {
                    var d = data.nonvalid;


                    console.log("data.nonvalid");
                    console.log(this);
                    trNSHTML += '<tr><td>' + this.Title + '</td><td>' + this.Product + '</td><td>' + this.AVG_Rating + '</td></tr>';

                });
                $.each(data.prior, function () {
                    var d = data.prior;


                    console.log("data.prior");
                    console.log(this);
                    trPriorHTML += '<tr><td>' + this[0] + '</td><td>' + this[1] + '</td></tr>';

                });


                $("#tblNextStageValidData > tbody").html("");
                $('#tblNextStageValidData').append(trSHTML);

                $("#tblNextStageNonValidData > tbody").html("");
                $('#tblNextStageNonValidData').append(trNSHTML);

                $("#tblApriorData > tbody").html("");
                $('#tblApriorData').append(trPriorHTML);


                $('.nav-tabs a[href="#tab2"]').tab('show');

            };

            return false;
        }
    </script>
</asp:Content>
