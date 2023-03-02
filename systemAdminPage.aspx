<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="systemAdminPage.aspx.cs" Inherits="milestone3.systemAdminPage" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
        <div>

            Add New Club:<br />
            Club Name<br />
            <asp:TextBox ID="clubNameforADD" runat="server" OnTextChanged="TextBox1_TextChanged"></asp:TextBox>
            <br />
            Club Location<br />
            <asp:TextBox ID="clubLoc" runat="server" OnTextChanged="clubLoc_TextChanged"></asp:TextBox>
            <br />
            <asp:Button ID="addClub" runat="server" Text="Add" OnClick="addClub_Click" />
            <br />
            <br />
&nbsp;Delete Club:<br />
            Club Name<br />
            <asp:TextBox ID="clubNameFordelete" runat="server" OnTextChanged="clubNameFordelete_TextChanged"></asp:TextBox>
            <br />
            <asp:Button ID="deleteClub" runat="server" Text="Delete" OnClick="deleteClub_Click" />
            <br />
            <br />
            Add New Stadium:<br />
            <asp:Label ID="Label1" runat="server" Text="Name"></asp:Label>

            <br />
            <asp:TextBox ID="stadNameforADD" runat="server" OnTextChanged="stadNameforADD_TextChanged"></asp:TextBox>
            <br />
            Location<br />
            <asp:TextBox ID="Location" runat="server" OnTextChanged="Location_TextChanged"></asp:TextBox>
            <br />
            Capacity<br />
            <asp:TextBox ID="Capacity" runat="server" OnTextChanged="Capacity_TextChanged"></asp:TextBox>
            <br />
            <asp:Button ID="addStad" runat="server" Text="Add" OnClick="addStad_Click" />
            <br />
            <br />
            Delete Stadium<br />
            Name<br />
            <asp:TextBox ID="stadName" runat="server" OnTextChanged="TextBox7_TextChanged"></asp:TextBox>
            <br />
            <asp:Button ID="deleteStad" runat="server" Text="Delete" OnClick="deleteStad_Click" />
            <br />
            <br />
            Block Fan<br />
            National ID Number<br />
            <asp:TextBox ID="fanID" runat="server" OnTextChanged="fanID_TextChanged"></asp:TextBox>

            <br />
            <asp:Button ID="blockButton" runat="server" Text="Block" OnClick="blockButton_Click" style="height: 26px" />

            <br />

        </div>
    </form>
</body>
</html>
