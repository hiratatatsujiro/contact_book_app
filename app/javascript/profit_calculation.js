function profit_calculation(){
const item_price = document.getElementById("item-price");
if (!item_price){ return false;}
item_price.addEventListener("input", () => {
  const add_tax_price = document.getElementById("add-tax-price");
  const profit = document.getElementById("profit");
  const fee = 0.1;
  const sales_commission = Math.floor(item_price.value * fee);
  add_tax_price.innerHTML = sales_commission;
  profit.innerHTML = item_price.value - sales_commission;
});
};

window.addEventListener("load", profit_calculation);