using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.Configuration;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace milestone3
{
    public partial class clubRepLogin : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void login_Click(object sender, EventArgs e)
        {
            String connStr = WebConfigurationManager.ConnectionStrings["project"].ToString();
            SqlConnection conn = new SqlConnection(connStr);

            String name = TextBox1.Text;
            String userName = usernameCR.Text;
            String passWord = passwordCR.Text;
            String club = TextBox2.Text;
            conn.Open();


            SqlCommand checkUsername = new SqlCommand("checkUsername", conn);
            checkUsername.CommandType = CommandType.StoredProcedure;
            checkUsername.Parameters.Add(new SqlParameter("@username", usernameCR.Text));
            SqlParameter check0 = checkUsername.Parameters.Add("@check", SqlDbType.Int);
            check0.Direction = ParameterDirection.Output;
            checkUsername.ExecuteNonQuery();

            SqlCommand checkIfClubInSystem = new SqlCommand("checkIfClubInSystem", conn);
            checkIfClubInSystem.CommandType = CommandType.StoredProcedure;
            checkIfClubInSystem.Parameters.Add(new SqlParameter("@clubname", club));
            SqlParameter check1 = checkIfClubInSystem.Parameters.Add("@check", SqlDbType.Int);
            check1.Direction = ParameterDirection.Output;
            checkIfClubInSystem.ExecuteNonQuery();


            SqlCommand checkIfClubHasRep = new SqlCommand("checkIfClubHasRep", conn);
            checkIfClubHasRep.CommandType = CommandType.StoredProcedure;
            checkIfClubHasRep.Parameters.Add(new SqlParameter("@clubname", club));
            SqlParameter check2 = checkIfClubHasRep.Parameters.Add("@check", SqlDbType.Int);
            check2.Direction = ParameterDirection.Output;
            checkIfClubHasRep.ExecuteNonQuery();


            if (check0.Value.ToString() == "1")
            {
                Response.Write("username already in use");
            }
            else
            {

                if (check1.Value.ToString() == "0")
                {
                    Response.Write("club does not exist");
                }
                else
                {
                    if (check2.Value.ToString() == "1")
                    {
                        Response.Write("club already has a representative");
                    }
                    else
                    {
                        SqlCommand addRepresentative = new SqlCommand("addRepresentative", conn);
                        addRepresentative.CommandType = CommandType.StoredProcedure;
                        addRepresentative.Parameters.Add(new SqlParameter("@name", name));
                        addRepresentative.Parameters.Add(new SqlParameter("@clubName", club));
                        addRepresentative.Parameters.Add(new SqlParameter("@username", usernameCR.Text));
                        addRepresentative.Parameters.Add(new SqlParameter("@password", passWord));
                        addRepresentative.ExecuteNonQuery();
                        Response.Redirect("clubRepPage.aspx?userName="+userName);
                    }
                }
            }

            conn.Close();   
        }

        protected void username_TextChanged(object sender, EventArgs e)
        {

        }

        protected void password_TextChanged(object sender, EventArgs e)
        {

        }

        protected void TextBox1_TextChanged(object sender, EventArgs e)
        {

        }

        protected void TextBox2_TextChanged(object sender, EventArgs e)
        {

        }
    }
}