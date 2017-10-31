using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Web;
using DAL;
using Newtonsoft.Json;
namespace CustomerStaApp.Handler
{
    /// <summary>
    /// Summary description for GetChartRegionNamehandler
    /// </summary>
    public class GetChartRegionNamehandler : IHttpHandler
    {

        public void ProcessRequest(HttpContext context)
        {
            context.Response.ContentType = "text/plain";

            string Recency = context.Request.QueryString["Recency"];
            string Frequency = context.Request.QueryString["Frequency"];
            string Monetary = context.Request.QueryString["Monetary"];
            string chartTpe = context.Request.QueryString["chartTpe"];


            Db db = new Db();

            List<SqlParameter> list = new List<SqlParameter>
            {
                new SqlParameter
                {
                    ParameterName = "@Recency",
                    Value = Recency
                },
                new SqlParameter
                {
                    ParameterName = "@Frequency",
                    Value = Frequency
                },
                new SqlParameter
                {
                    ParameterName = "@Monetary",
                    Value = Monetary
                },
                new SqlParameter
                {
                    ParameterName = "@chartTpe",
                    Value = chartTpe
                },
            };

           

            DataSet dataSet = db.GetDataSet("spGetChartRegionName", list);
            string jsonNet = DataTableToJsonWithJsonNet(dataSet.Tables[0]);
            context.Response.Write(jsonNet);
        }

        public bool IsReusable
        {
            get
            {
                return false;
            }
        }

        public string DataTableToJsonWithJsonNet(DataTable table)
        {
            var jsonString = JsonConvert.SerializeObject(table);
            return jsonString;
        }
    }
}