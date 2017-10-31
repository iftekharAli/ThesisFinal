function plotChart(canvasID, data) {

    
    var ctx = document.getElementById(canvasID).getContext('2d');
    var chart = new Chart(ctx,
        {
           

            // The type of chart we want to create
            type: 'horizontalBar',
            // The data for our dataset
            data: {

                labels: data.Product.map(function (a) { return a.ProductName; }),
                datasets: [
                    {
                        label: data.Title,
                        backgroundColor: 'rgb(255, 99, 132)',
                        borderColor: 'rgb(255, 99, 132)',
                        data: data.Product.map(function (a) { return a.TotalQuantity; })
                    },
                    {
                        label: "Rating",
                        backgroundColor: '#4EA0AB',
                        borderColor: 'rgb(255, 99, 132)',
                        data: data.Product.map(function (a) { return a.avg_rating; })
                    }
                ]
            },

            // Configuration options go here
            options: {
                scales: {
                    xAxes: [
                        {
                            stacked: true,

                        }
                    ],
                    yAxes: [
                        {
                            stacked: true,
                            ticks: {
                                beginAtZero: true,
                                min: 10,
                                suggestedMin: 0
                            }
                        }
                    ]
                }
            }
        });

}