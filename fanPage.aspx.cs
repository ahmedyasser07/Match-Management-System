using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.Configuration;
using System.Reflection.Emit;

namespace milestone3
{
    public partial class fanPage : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            String connStr = WebConfigurationManager.ConnectionStrings["project"].ToString();
            SqlConnection conn = new SqlConnection(connStr);

            DateTime date = DateTime.Parse(TextBox1.Text.ToString()); 
            conn.Open();

            SqlCommand checkIfthereAreMatches = new SqlCommand("checkIfthereAreMatches", conn);
            checkIfthereAreMatches.CommandType = CommandType.StoredProcedure;
            checkIfthereAreMatches.Parameters.Add(new SqlParameter("@start", date));
            SqlParameter checkBit = checkIfthereAreMatches.Parameters.Add("@check", SqlDbType.Int);
            checkBit.Direction = ParameterDirection.Output;
            checkIfthereAreMatches.ExecuteNonQuery();

            if (checkBit.Value.ToString() == "0")
            {
                Label1.Text = "No matches Available On This Date";
            }
            else
            {
                String query = "select * from availableMatchesToAttend('"+date+"'";
                SqlDataAdapter sqlDA = new SqlDataAdapter(query, conn);
                DataTable tbl = new DataTable();
                sqlDA.Fill(tbl);
                GridView1.DataSource = tbl;
                GridView1.DataBind();
            }
            conn.Close();
        }

        protected void TextBox1_TextChanged(object sender, EventArgs e)
        {

        }

        protected void GridView1_SelectedIndexChanged(object sender, EventArgs e)
        {

        }

        protected void TextBox2_TextChanged(object sender, EventArgs e)
        {

        }

        protected void TextBox3_TextChanged(object sender, EventArgs e)
        {

        }

        protected void TextBox4_TextChanged(object sender, EventArgs e)
        {

        }

        protected void Button1_Click(object sender, EventArgs e)
        {

            String connStr = WebConfigurationManager.ConnectionStrings["project"].ToString();
            SqlConnection conn = new SqlConnection(connStr);

            String id = Request.QueryString["id"].ToString();
            String host = TextBox2.Text;
            String guest = TextBox3.Text;
            DateTime start = DateTime.Parse(TextBox4.Text.ToString());
            conn.Open();

            SqlCommand checkifmatchcanbeAttended = new SqlCommand("checkifmatchcanbeAttended", conn);
            checkifmatchcanbeAttended.CommandType = CommandType.StoredProcedure;
            checkifmatchcanbeAttended.Parameters.Add(new SqlParameter("@fanID", id));
            checkifmatchcanbeAttended.Parameters.Add(new SqlParameter("@host", host));
            checkifmatchcanbeAttended.Parameters.Add(new SqlParameter("@guest", guest));
            checkifmatchcanbeAttended.Parameters.Add(new SqlParameter("@start", start));
            SqlParameter checkBit = checkifmatchcanbeAttended.Parameters.Add("@check", SqlDbType.Int);
            checkBit.Direction = ParameterDirection.Output;
            checkifmatchcanbeAttended.ExecuteNonQuery();

            if (checkBit.Value.ToString() == "0")
            {
                Label2.Text = "match can't be attended (match not available anymore or you're blocked";
            }
            else
            {
                SqlCommand purchaseTicket = new SqlCommand("purchaseTicket", conn);
                purchaseTicket.CommandType = CommandType.StoredProcedure;
                purchaseTicket.Parameters.Add(new SqlParameter("@fanID", id));
                purchaseTicket.Parameters.Add(new SqlParameter("@hostName", host));
                purchaseTicket.Parameters.Add(new SqlParameter("@guestName", guest));
                purchaseTicket.Parameters.Add(new SqlParameter("@start", start));
                purchaseTicket.ExecuteNonQuery();
                Label2.Text = "ticket purchased";
            }
            conn.Close();   
        }
    }
}