using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.Configuration;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Reflection;

namespace milestone3
{
    public partial class stadiumManagerPage : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            String connStr = WebConfigurationManager.ConnectionStrings["project"].ToString();
            SqlConnection conn = new SqlConnection(connStr);
            conn.Open();

            String userName = Request.QueryString["userName"];
            Response.Write("hello " + userName);
            String query = "select s.id, s.stadium_name, s.stadium_location, s.capacity, s.stadium_status from stadium s inner join stadium_manager m on s.id = m.stadium_id where m.username = '" + userName + "'";

            SqlDataAdapter sqlDA = new SqlDataAdapter(query, conn);
            DataTable tbl = new DataTable();
            sqlDA.Fill(tbl);
            GridView1.DataSource = tbl;
            GridView1.DataBind();


            String query1 = "select * from allPendingRequests ('" + userName + "')";

            SqlDataAdapter sqlDA1 = new SqlDataAdapter(query1, conn);
            DataTable tbl1 = new DataTable();
            sqlDA1.Fill(tbl1);
            GridView2.DataSource = tbl1;
            GridView2.DataBind();
        }

        protected void GridView1_SelectedIndexChanged(object sender, EventArgs e)
        {

        }

        protected void GridView2_SelectedIndexChanged(object sender, EventArgs e)
        {

        }

        protected void TextBox1_TextChanged(object sender, EventArgs e)
        {

        }

        protected void TextBox2_TextChanged(object sender, EventArgs e)
        {

        }

        protected void TextBox3_TextChanged(object sender, EventArgs e)
        {

        }

        protected void Button1_Click(object sender, EventArgs e)
        {
            //accept

            String connStr = WebConfigurationManager.ConnectionStrings["project"].ToString();
            SqlConnection conn = new SqlConnection(connStr);
            conn.Open();

            String userName = Request.QueryString["userName"];
            String host = TextBox1.Text;
            String guest = TextBox2.Text;
            DateTime start = DateTime.Parse(TextBox3.Text.ToString());

           // @stadUser varchar(20),
           // @host varchar(20),
            //@guest varchar(20),
           // @start datetime,
           // @check bit output


            SqlCommand checkifrequestisUNHANDLED = new SqlCommand("checkifrequestisUNHANDLED", conn);
            checkifrequestisUNHANDLED.CommandType = CommandType.StoredProcedure;
            checkifrequestisUNHANDLED.Parameters.Add(new SqlParameter("@stadUser", userName));
            checkifrequestisUNHANDLED.Parameters.Add(new SqlParameter("@host", host));
            checkifrequestisUNHANDLED.Parameters.Add(new SqlParameter("@guest", guest));
            checkifrequestisUNHANDLED.Parameters.Add(new SqlParameter("@start", start));
            SqlParameter checkBit = checkifrequestisUNHANDLED.Parameters.Add("@check", SqlDbType.Int);
            checkBit.Direction = ParameterDirection.Output;
            checkifrequestisUNHANDLED.ExecuteNonQuery();

            if (checkBit.Value.ToString() == "0")
            {
                Label1.Text = "This request has been handled (Accepted/Rejected)";
            }
            else
            {
                SqlCommand acceptRequest = new SqlCommand("acceptRequest", conn);
                acceptRequest.CommandType = CommandType.StoredProcedure;
                acceptRequest.Parameters.Add(new SqlParameter("@stadiumManager_username", userName));
                acceptRequest.Parameters.Add(new SqlParameter("@hostClub", host));
                acceptRequest.Parameters.Add(new SqlParameter("@guestClub", guest));
                acceptRequest.Parameters.Add(new SqlParameter("@start", start));
                acceptRequest.ExecuteNonQuery();
                Label1.Text = "This request has been Accepted";

            }
            conn.Close();
        }

        protected void Button2_Click(object sender, EventArgs e)
        {
            //reject

            String connStr = WebConfigurationManager.ConnectionStrings["project"].ToString();
            SqlConnection conn = new SqlConnection(connStr);
            conn.Open();

            String userName = Request.QueryString["userName"];
            String host = TextBox1.Text;
            String guest = TextBox2.Text;
            DateTime start = DateTime.Parse(TextBox3.Text.ToString());

            // @stadUser varchar(20),
            // @host varchar(20),
            //@guest varchar(20),
            // @start datetime,
            // @check bit output


            SqlCommand checkifrequestisUNHANDLED = new SqlCommand("checkifrequestisUNHANDLED", conn);
            checkifrequestisUNHANDLED.CommandType = CommandType.StoredProcedure;
            checkifrequestisUNHANDLED.Parameters.Add(new SqlParameter("@stadUser", userName));
            checkifrequestisUNHANDLED.Parameters.Add(new SqlParameter("@host", host));
            checkifrequestisUNHANDLED.Parameters.Add(new SqlParameter("@guest", guest));
            checkifrequestisUNHANDLED.Parameters.Add(new SqlParameter("@start", start));
            SqlParameter checkBit = checkifrequestisUNHANDLED.Parameters.Add("@check", SqlDbType.Int);
            checkBit.Direction = ParameterDirection.Output;
            checkifrequestisUNHANDLED.ExecuteNonQuery();

            if (checkBit.Value.ToString() == "0")
            {
                Label1.Text = "This request has been handled (Accepted/Rejected)";
            }
            else
            {
                SqlCommand rejectRequest = new SqlCommand("rejectRequest", conn);
                rejectRequest.CommandType = CommandType.StoredProcedure;
                rejectRequest.Parameters.Add(new SqlParameter("@stadiumManager_username", userName));
                rejectRequest.Parameters.Add(new SqlParameter("@hostClub", host));
                rejectRequest.Parameters.Add(new SqlParameter("@guestClub", guest));
                rejectRequest.Parameters.Add(new SqlParameter("@start", start));
                rejectRequest.ExecuteNonQuery();
                Label1.Text = "This request has been Rejected";

            }
            conn.Close();


        }
    }
}