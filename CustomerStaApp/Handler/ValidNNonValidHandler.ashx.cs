using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.IO;
using System.Linq;
using System.Web;
using DAL;

namespace CustomerStaApp.Handler
{
    /// <summary>
    /// Summary description for ValidNNonValidHandler
    /// </summary>
    public class ValidNNonValidHandler : IHttpHandler
    {

        public void ProcessRequest(HttpContext context)
        {
            context.Response.ContentType = "text/plain";

            string Recency = context.Request.QueryString["Recency"];
            string Frequency = context.Request.QueryString["Frequency"];
            string Monetary = context.Request.QueryString["Monetary"];
            string DataType = context.Request.QueryString["DataType"];
            string Rating = context.Request.QueryString["Rating"];
            string Valid = context.Request.QueryString["Valid"];

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
                    ParameterName="@Title",
                    Value = json.Replace("[",string.Empty).Replace("]",string.Empty).Replace("\"",string.Empty)
                },
                new SqlParameter
                {
                    ParameterName="@DataType",
                    Value = DataType
                }, new SqlParameter
                {
                    ParameterName="@Rating",
                    Value = Rating
                }

            };
            DataSet dataSet = null;

            if (Valid=="1")
            {
                 dataSet = db.GetDataSet("spGetValidDataSet", list);
            }
            else
            {
                dataSet = db.GetDataSet("spGetNonValidDataSet", list);

            }


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
    }
}