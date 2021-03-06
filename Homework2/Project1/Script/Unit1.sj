function Main()
{
  try
  {
    // Enter your code here. 
  }
  catch(exception)
  {
    Log.Error("Exception", exception.description);
  }
}

function Test1()
{
  openOrder();
for(var i = 0; i < 2; i++)
  {
  var file = Files.FileNameByName("input.csv");
  var driver = DDT.CSVDriver(file);
  
  
  while(!driver.EOF())
  {
    var pn = driver.Value(0);
    var quan = driver.Value(1);
    var pr = driver.Value(2);
    var dis = driver.Value(3);
    var date = driver.Value(4);
    var cust = driver.Value(5);
    var street = driver.Value(6);
    var city = driver.Value(7);
    var state = driver.Value(8);
    var zip = driver.Value(9);
    var card = driver.Value(10);
    var cn = driver.Value(11);
    var ed = driver.Value(12);
    
    script(pn, quan, pr, dis, date, cust, street, city, state, zip, card, cn, ed);
    
    driver.Next();
  }
  }
 DDT.CloseDriver(file);
 cleanOrders()
 cleanup();
  
}

function openOrder()
{
  TestedApps.Orders.Run();
}


function script(productNames, quantity, price, discount, date, customer, street, city, state, zip, card, cardNo, expDate)
{
  Aliases.Orders.MainForm.MainMenu.Click("Orders|New order...");
  Aliases.Orders.OrderForm.Group.ProductNames.ClickItem(productNames);
  Aliases.Orders.OrderForm.Group.Quantity.wValue = quantity;
  Aliases.Orders.OrderForm.Group.Price.wText = "$" + price;
  Aliases.Orders.OrderForm.Group.Discount.wText = discount + "%"
  // Поле groupBox1.Total.wText является необязательным поскольку заполняется
  // автматически исходя из существующих параметров. 
  //Aliases.Orders.OrderForm.Group.groupBox1.Total.wText = "340";
  Aliases.Orders.OrderForm.Group.Date.wDate = date;
  Aliases.Orders.OrderForm.Group.Customer.wText = customer;
  Aliases.Orders.OrderForm.Group.Street.wText = street;
  Aliases.Orders.OrderForm.Group.City.wText = city;
  Aliases.Orders.OrderForm.Group.Zip.wText = zip;
  Aliases.Orders.OrderForm.Group.State.wText = state;
  
  if(card == "Visa")
  {
   Aliases.Orders.OrderForm.Group.Visa.ClickButton();
  }
  else if(card == "AE")
  {
   Aliases.Orders.OrderForm.Group.AE.ClickButton();
  }
  else if(card == "MasterCard")
  {
   Aliases.Orders.OrderForm.Group.MasterCard.ClickButton();
  }
  
  Aliases.Orders.OrderForm.Group.CardNo.wText = cardNo;
  Aliases.Orders.OrderForm.Group.ExpDate.wDate = expDate;
  Aliases.Orders.OrderForm.ButtonOK.ClickButton();
  aqObject.CompareProperty(Aliases.Orders.MainForm.OrdersView.wSelectedItems, 0, customer, false);

}

function cleanOrders()
{
var i = 0;
while(i < 10)
{
  Aliases.Orders.MainForm.OrdersView.FocusItem(0);
  Aliases.Orders.MainForm.OrdersView.Keys("[Del]");
  Aliases.Orders.dlgConfirmation.btnYes.Keys("[Enter]");
  i++;
}
}

function cleanup()
{
  Aliases.Orders.MainForm.Close();
  Aliases.Orders.dlgConfirmation.btnNo.ClickButton();
}
