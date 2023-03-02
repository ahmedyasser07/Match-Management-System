<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="clubRepPage.aspx.cs" Inherits="milestone3.clubRepPage" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
        <div>
            <br />
            My Club Info<asp:GridView ID="GridView1" runat="server" OnSelectedIndexChanged="GridView1_SelectedIndexChanged">
            </asp:GridView>
            <br />
            <br />
            Upcoming Matches for my Club<br />
            <asp:GridView ID="GridView2" runat="server" OnSelectedIndexChanged="GridView2_SelectedIndexChanged">
            </asp:GridView>
            <br />
            <br />
            View all Available Stadiums Starting from:<br />
            <asp:TextBox ID="TextBox1" type="datetime-local" runat="server" OnTextChanged="TextBox1_TextChanged"></asp:TextBox>
            <br />
            <asp:Button ID="Button1" runat="server" Text="View" OnClick="Button1_Click" />
            <br />
            <br />
            Send Host Request:<br />
            Stadium Name<br />
            <asp:TextBox ID="TextBox2" runat="server" OnTextChanged="TextBox2_TextChanged"></asp:TextBox>
            <br />
            Time<br />
            <asp:TextBox ID="TextBox3" runat="server" type="datetime-local" OnTextChanged="TextBox3_TextChanged"></asp:TextBox>
            <br />
            <asp:Button ID="Button2" runat="server" Text="Send" OnClick="Button2_Click" />
            <br />
            <asp:Label ID="Label1" runat="server" Text=""></asp:Label>
        </div>
    </form>
</body>
</html>
