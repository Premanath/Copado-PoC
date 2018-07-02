global class AshishWebService{
    webService static void fetchAccount() {
   
      System.debug('You are in bro!!');
       List<Account> lstAcc =[select id,name from account limit 10];
       
       //return lstAcc;
    }
}