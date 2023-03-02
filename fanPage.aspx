<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="fanPage.aspx.cs" Inherits="milestone3.fanPage" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
        <div>
            View Available Matches ON:&nbsp;
            <asp:TextBox ID="TextBox1" type="datetime-local" runat="server" OnTextChanged="TextBox1_TextChanged"></asp:TextBox>
            <br />
            <asp:Label ID="Label1" runat="server" Text=""></asp:Label>
            <asp:GridView ID="GridView1" runat="server" OnSelectedIndexChanged="GridView1_SelectedIndexChanged">
            </asp:GridView>
            <br />
            Purchase a Ticket<br />
            Host<br />
            <asp:TextBox ID="TextBox2" runat="server" OnTextChanged="TextBox2_TextChanged"></asp:TextBox>
            <br />
            Guest<br />
            <asp:TextBox ID="TextBox3" runat="server" OnTextChanged="TextBox3_TextChanged"></asp:TextBox>
            <br />
            Start<br />
            <asp:TextBox ID="TextBox4" type="datetime-local" runat="server" OnTextChanged="TextBox4_TextChanged"></asp:TextBox>
            <br />
            <asp:Label ID="Label2" runat="server" Text=""></asp:Label>
            <br />
            <asp:Button ID="Button1" runat="server" Text="Purchase" OnClick="Button1_Click" />
        </div>
    </form>
</body>
</html>
