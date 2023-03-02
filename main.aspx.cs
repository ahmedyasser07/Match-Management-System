using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.Configuration;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace milestone3
{
    public partial class redirectPage : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

     

        protected void stadiumManager_Click(object sender, EventArgs e)
        {
            Response.Redirect("stadiumManagerRegister.aspx?");

        }

        protected void sportsManager_Click(object sender, EventArgs e)
        {
            Response.Redirect("sportsManagerLogin.aspx");
        }

        protected void clubRep_Click(object sender, EventArgs e)
        {
            Response.Redirect("clubRepreg.aspx");

        }

        protected void fan_Click(object sender, EventArgs e)
        {
            Response.Redirect("fanLogin.aspx");


        }

        protected void TextBox1_TextChanged(object sender, EventArgs e)
        {

        }

        protected void TextBox2_TextChanged(object sender, EventArgs e)
        {

        }

        protected void Button1_Click(object sender, EventArgs e)
        {
            String connStr = WebConfigurationManager.ConnectionStrings["project"].ToString();
            SqlConnection conn = new SqlConnection(connStr);

            String userName = TextBox1.Text;
            String passWord = TextBox2.Text;
            conn.Open();

            SqlCommand usersLogin = new SqlCommand("usersLogin", conn);
            usersLogin.CommandType = CommandType.StoredProcedure;
            usersLogin.Parameters.Add(new SqlParameter("@username", userName));
            usersLogin.Parameters.Add(new SqlParameter("@password", passWord));
            SqlParameter userType = usersLogin.Parameters.Add("@type", SqlDbType.Int);
            userType.Direction = ParameterDirection.Output;
            SqlParameter checkBit = usersLogin.Parameters.Add("@check", SqlDbType.Int);
            checkBit.Direction = ParameterDirection.Output;
            usersLogin.ExecuteNonQuery();

            if (checkBit.Value.ToString() == "0")
            {
                Response.Write("wrong credentials or user not registered");
            }
            else
            {
                if (userType.Value.ToString() == "1")
                {

                    Response.Redirect("systemAdminPage.aspx?userName="+userName);
                }
                if (userType.Value.ToString() == "2")
                {
                    Response.Redirect("sportsManagerPage.aspx?userName="+userName);
                }
                if (userType.Value.ToString() == "3")
                {
                    
                    Response.Redirect("clubRepPage.aspx?userName="+userName);
                }
                if (userType.Value.ToString() == "4")
                {
                    Response.Redirect("stadiumManagerPage.aspx?userName="+userName);
                }
                if (userType.Value.ToString() == "5")
                {
                    Response.Redirect("fanPage.aspx?userName="+userName);

                }

            }

            conn.Close();
        }
    }
}