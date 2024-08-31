<?php
include_once("../../header.php");
include_once("../../account.php");

// Check if the user is an admin (you can modify this logic as needed)
if (!isAdmin()) {
    $_SESSION['msg'] = "You must log in first";
    header('location: ../../login.php');
}

// Handle logout
if (isset($_GET['logout'])) {
    session_destroy();
    unset($_SESSION['user_info']);
    header("location: ../../login.php");
}

include 'action.php'; // Include your action file (where you handle database operations)

$invoice = new Invoice();

// Save invoice data when the form is submitted
if (!empty($_POST['companyName']) && $_POST['companyName']) {
    $invoice->saveInvoice($_POST); // Assuming you have a method to save invoice data
    header("Location: index.php"); // Redirect to the desired page after saving
}
?>
<body id="page-top">
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Invoice Details</title>
</head>
<body>
    <h1>Enter Invoice Details</h1>
    <form action="insert_data.php" method="post">
        <label for="invoice_id">Invoice ID:</label>
        <input type="text" id="invoice_id" name="invoice_id" required><br>

        <label for="customer_name">Customer Name:</label>
        <input type="text" id="customer_name" name="customer_name" required><br>

        <label for="invoice_date">Invoice Date:</label>
        <input type="date" id="invoice_date" name="invoice_date" required><br>

        <label for="total_amount">Total Amount:</label>
        <input type="number" step="0.01" id="total_amount" name="total_amount" required><br>

        <input type="submit" value="Save Invoice">
    </form>
</body>
</html>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Invoice Details</title>
</head>
<body>
    <h1>Enter Invoice Details</h1>
    <form action="insert_data.php" method="post">
        <!-- Your input fields for invoice details -->
        <label for="invoice_id">Invoice ID:</label>
        <input type="text" id="invoice_id" name="invoice_id" required><br>

        <!-- Other input fields go here -->

        <input type="submit" value="Save Invoice">
    </form>

    <!-- Separate button for printing -->
    <button onclick="printInvoice()">Print Invoice</button>

    <script>
        function printInvoice() {
            // Customize this function to include the content you want to print
            // For example, you can select specific elements or create a printable HTML structure
            // Then use the window.print() method to trigger the print dialog
            window.print();
        }
    </script>
</body>
</html>

<!-- You can also add printing functionality using JavaScript or a separate print button -->
</body>
