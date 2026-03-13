using Microsoft.AspNetCore.Identity;

namespace shadowpay_api.Models
{
    public class ApplicationUser :IdentityUser
    {
        public string CardNumberHash {  get; set; }
        public string CardHolderName { get; set; }
        public DateTime ExprDate { get; set; }
        public ICollection<Transaction> Transactions { get; set; }  // Navigation Property

    }

}
