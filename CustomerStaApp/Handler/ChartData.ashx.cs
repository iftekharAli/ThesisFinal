using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.IO;
using System.Linq;
using System.Web;
using DAL;
using Newtonsoft.Json;
using Newtonsoft.Json.Linq;

namespace CustomerStaApp.Handler
{
    /// <summary>
    /// Summary description for ChartData
    /// </summary>
    public class ChartData : IHttpHandler
    {

        public void ProcessRequest(HttpContext context)
        {
            context.Response.ContentType = "text/plain";

            string Recency = context.Request.QueryString["Recency"];
            string Frequency = context.Request.QueryString["Frequency"];
            string Monetary = context.Request.QueryString["Monetary"];
            string chartTpe = context.Request.QueryString["chartTpe"];

            string json = new StreamReader(context.Request.InputStream).ReadToEnd();


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
                }
                ,new SqlParameter
                {
                    ParameterName="@ChartTitle",
                    Value = json.Replace("[",string.Empty).Replace("]",string.Empty).Replace("\"",string.Empty)
                },
                new SqlParameter
                {
                    ParameterName="@chartTpe",
                    Value = chartTpe
                }

            };


            DataSet dataSet = db.GetDataSet("spGetChartData", list);


            string jsonNet = dataSet.Tables[0].Rows[0][0].ToString();
            context.Response.Write(jsonNet);
        }

        public bool IsReusable
        {
            get
            {
                return false;
            }
        }
        private  void Dump(JToken token, string indent)
        {
            Console.Write(indent);
            if (token == null)
            {
                Console.WriteLine("null");
                return;
            }
            Console.Write(token.Type);

            if (token is JProperty)
                Console.Write(" (name=" + ((JProperty)token).Name + ")");
            else if (token is JValue)
                Console.Write(" (value=" + token.ToString() + ")");

            Console.WriteLine();

            if (token.HasValues)
                foreach (JToken child in token.Children())
                    Dump(child, indent + "  ");

        }
        public string DataTableToJSONWithJSONNet(DataTable table)
        {
            string JSONString = string.Empty;
            JSONString = JsonConvert.SerializeObject(table);

            var textReader = new StringReader(JSONString);
            JsonTextReader jsonReader = new JsonTextReader(textReader);
            jsonReader.Read();
            while (jsonReader.Read())
            {
                if (jsonReader.TokenType == JsonToken.StartObject)
                {
                    JObject tbox = JObject.Load(jsonReader);
                }
            }

            return JSONString;
        }
    }
}