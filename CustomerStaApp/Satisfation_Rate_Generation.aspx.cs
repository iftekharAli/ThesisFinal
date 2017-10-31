using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using DAL;

namespace CustomerStaApp
{
    public partial class Satisfation_Rate_Generation : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            lblMsg.Visible = false;
            if (!IsPostBack)
            {

            }
        }

        protected void btnSubmit_OnClick(object sender, EventArgs e)
        {
            var Recency = Request.QueryString["Recency"];
            var Frequency = Request.QueryString["Frequency"];
            var Monetary = Request.QueryString["Monetary"];
            var Rating = txtRating.Text;

            Db db = new Db();
            List<SqlParameter> sqlParameters =
                new List<SqlParameter>
                {
                    new SqlParameter {ParameterName = "@Recency", Value = Recency},
                    new SqlParameter {ParameterName = "@Frequency", Value = Frequency},
                    new SqlParameter {ParameterName = "@Monetary", Value = Monetary},
                    new SqlParameter {ParameterName = "@Rating", Value = Rating}
                };
            DataSet dataSet = db.GetDataSet("spSatisfation_Rate_Generation", sqlParameters);

            grdSatisfation_Rate_Generation.DataSource = dataSet.Tables[0];
            grdSatisfation_Rate_Generation.DataBind();
            grdDisSatisfation_Rate_Generation.DataSource = dataSet.Tables[1];
            grdDisSatisfation_Rate_Generation.DataBind();
        }

        protected void btnSave_OnClick(object sender, EventArgs e)
        {


            var Recency = Request.QueryString["Recency"];
            var Frequency = Request.QueryString["Frequency"];
            var Monetary = Request.QueryString["Monetary"];
            var Rating = txtRating.Text;

            Db db = new Db();
            List<SqlParameter> sqlParameters =
                new List<SqlParameter>
                {
                    new SqlParameter {ParameterName = "@Recency", Value = Recency},
                    new SqlParameter {ParameterName = "@Frequency", Value = Frequency},
                    new SqlParameter {ParameterName = "@Monetary", Value = Monetary},
                    new SqlParameter {ParameterName = "@Rating", Value = Rating}
                };
            db.ExecuteNonQuery("spSaveSatisfiedCustomerData", sqlParameters);
            lblMsg.Visible = true;
            lblMsg.Text = "Saved";
        }
    }
}