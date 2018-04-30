<?php
define("DB_SERVER", "localhost");
define("DB_USER", "root");
define("DB_PASSWORD", "");
define("DB_DATABASE", "zoo");

// Create connection
$conn = mysqli_connect(DB_SERVER , DB_USER, DB_PASSWORD, DB_DATABASE);

if(!$conn)
{
die("Connection failed: " . mysqli_connect_error());
}


/*
$sql= "CREATE TABLE Membership (
  member_id INT not null,
  start_date DATE not null,
  mem_name VARCHAR(20) not null,
  mem_address VARCHAR(20) not null,
  mem_email VARCHAR(20) not null,
  mem_phone INT not null
  member_lvl varchar(20) not null,
  vis_id INT not null,
  PRIMARY KEY (member_id) )";*/





//Create random number for ID
$id = rand(4000,9000);

//Insert values

// Before using $_POST['value']
if (isset($_POST['Submit']))
{
// Instructions if $_POST['Submit'] exist

$sql = "INSERT INTO Membership (member_id, mem_name,start_date, mem_address,mem_email, mem_phone)
        VALUES('$_POST[id]','$_POST[name]', '$_POST[start_date]', '$_POST[address]', '$_POST[email]','$_POST[telephone]')";
 $result = mysqli_query($conn,$sql);
}

$conn->close();


//Posts results to the Table
$conn = mysqli_connect(DB_SERVER , DB_USER, DB_PASSWORD, DB_DATABASE);
$result=mysqli_query($conn, "SELECT * FROM Membership");

echo "<table>";

while($row = mysqli_fetch_array($result)){
echo "<tr><td>" . $row['member_id'] . "</td><td>" . $row['start_date'] . "</td></tr>" . $row['mem_name'] ."</td></tr>" . $row['mem_address'] . "/td></tr>" . $row['mem_email'] . "</td></tr>". $row['mem_phone'];
}

echo "</table>";

mysqli_close($conn);
?>
