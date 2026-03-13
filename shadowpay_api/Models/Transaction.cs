namespace shadowpay_api.Models
{
    public class Transaction
    {
        public int Id { get; set; }
        public string UserId { get; set; }
        public decimal Amount { get; set; }
        public string MerchantCategory { get; set; }
        public int ZipCode { get; set; }
        public int TransactionHour { get; set; }
        public double RiskScore { get; set; }
        public bool IsFraud { get; set; }
        public string RiskLevel { get; set; }
    }
}
