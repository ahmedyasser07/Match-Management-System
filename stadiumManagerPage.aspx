<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="stadiumManagerPage.aspx.cs" Inherits="milestone3.stadiumManagerPage" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
        <div>
            My Stadium
            <br />
            <asp:GridView ID="GridView1" runat="server" OnSelectedIndexChanged="GridView1_SelectedIndexChanged">
            </asp:GridView>


            <br />
            All Requests<asp:GridView ID="GridView2" runat="server" OnSelectedIndexChanged="GridView2_SelectedIndexChanged">
            </asp:GridView>
            <br />
            Host Request<br />
            Host<br />
            <asp:TextBox ID="TextBox1" runat="server" OnTextChanged="TextBox1_TextChanged"></asp:TextBox>
            <br />
            Guest<br />
            <asp:TextBox ID="TextBox2" runat="server" OnTextChanged="TextBox2_TextChanged"></asp:TextBox>
            <br />
            Start Time<br />
            <asp:TextBox ID="TextBox3" type="datetime-local" runat="server" OnTextChanged="TextBox3_TextChanged"></asp:TextBox>
            <br />
            <asp:Label ID="Label1" runat="server" Text=""></asp:Label>
            <br />
            <asp:Button ID="Button1" runat="server" Text="Accept" OnClick="Button1_Click" />


        &nbsp;&nbsp;
            <asp:Button ID="Button2" runat="server" Text="Reject" OnClick="Button2_Click" />


        </div>
    </form>
</body>
</html>
