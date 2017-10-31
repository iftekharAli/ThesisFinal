using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using DAL;

namespace CustomerStaApp
{
    public partial class Customer_Data_Validation : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {

            }
        }

        protected void btnSubmit_OnClick(object sender, EventArgs e)
        {
            var Recency = txtRecency.Text;
            var Frequency = txtFrequency.Text;
            var Monetary = txtMonetary.Text;

            Db db = new Db();
            List<SqlParameter> sqlParameters =
                new List<SqlParameter>
                {
                    new SqlParameter {ParameterName = "@Recency", Value = Recency},
                    new SqlParameter {ParameterName = "@Frequency", Value = Frequency},
                    new SqlParameter {ParameterName = "@Monetary", Value = Monetary}
                };
            DataSet dataSet = db.GetDataSet("spCustomerValidation", sqlParameters);

            grdValidData.DataSource = dataSet;
            grdValidData.DataBind();
        }

        protected void lnkSatisfationRateGeneration_OnClick(object sender, EventArgs e)
        {
            Response.Redirect("~/Satisfation_Rate_Generation.aspx?Recency=" + txtRecency.Text + "&Frequency=" + txtFrequency.Text
                + "&Monetary=" + txtMonetary.Text, true);
        }
    }
}