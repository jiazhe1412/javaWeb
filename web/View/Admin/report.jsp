<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Report</title>
        <!-- To access the chart -->
        <script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.5.0/Chart.min.js"></script>
        <link href="../CSS/report.css" rel="stylesheet" type="text/css"/>
        <meta name="viewport" content="width=device-width, initial-scale=1">
       <%@ include file = "sideNavForStaff.jsp" %>

    </head>
    <body>
      
        <div class="container">
            <div id="firstcol">
                <div class="amountEarn">
                    <table>
                        <tr>
                            <th>This month earned</th>
                        </tr>
                        <tr>
                            <td>$ 852</td>
                        </tr>
                    </table>
                </div>
                <div class="inventory">
                    <canvas  id="pieChart"></canvas>
                    <script>
                        var Xvalues = ["Beds and Furnitures", "Cat Foods", "Dog Foods", "Toys"];
                        var Yvalues = [12,5,5,14];
                        var barColors = ["red", "blue", "purple", "green"];

                        new Chart("pieChart", {
                            type: "pie",
                            data: {
                                labels: Xvalues,
                                datasets: [{
                                        backgroundColor: barColors,
                                        data: Yvalues
                                    }]
                            },
                            options: {
                                legend: {display: false},
                                title: {
                                    display: true,
                                    text: "Current Inventory"
                                }
                            }
                        });
                    </script>
                </div>
            </div>
            <div id="secondcol">
                <div class="productCurrentMonthlySales">
                    <canvas  id="barChart"></canvas>
                    <script>
                        var Xvalues = ["Cat Foods", "Dog Foods", "Beds and Furnitures", "Toys"];
                        var Yvalues = [30, 24, 48, 49];
                        var barColors = ["red", "blue", "purple", "green"];

                        new Chart("barChart", {
                            type: "bar",
                            data: {
                                labels: Xvalues,
                                datasets: [{
                                        backgroundColor: barColors,
                                        data: Yvalues
                                    }]
                            },
                            options: {
                                legend: {display: false},
                                title: {
                                    display: true,
                                    text: "Product Sales in Current Month"
                                }
                            }
                        });
                    </script>
                </div>
                <div class="saleSummary">
                    <canvas  id="lineChart"></canvas>
                    <script>
                        var Xvalues =  ["Cat Foods", "Dog Foods", "Beds and Furnitures", "Toys"];
                        var Yvalues = [126,145,98,150];
                        var barColors = ["red", "green"];

                        new Chart("lineChart", {
                            type: "line",
                            data: {
                                labels: Xvalues,
                                datasets: [{
                                        backgroundColor: barColors,
                                        data: Yvalues
                                    }]
                            },
                            options: {
                                legend: {display: false},
                                title: {
                                    display: true,
                                    text: "saleSummary"
                                }
                            }
                        });
                    </script>
                </div>
                <button class="generate"><strong>Generate Report</strong></button>
            </div>
        </div>
    </body>
</html>
