using Microsoft.EntityFrameworkCore;
using shadowpay_api.Models;

namespace shadowpay_api.Data
{
    public class AppDbContext : DbContext
    {
        public AppDbContext(DbContextOptions<AppDbContext> options) :base (options) {}

        public DbSet<ApplicationUser> Users { get; set; }
        public DbSet<Transaction> Transactions { get; set; }

        protected override void OnModelCreating(ModelBuilder builder)
        {
            base.OnModelCreating(builder);

            builder.Entity<Transaction>()
                   .HasOne<ApplicationUser>()
                   .WithMany(u => u.Transactions)  // Navigation Property
                   .HasForeignKey(t => t.UserId)
                   .OnDelete(DeleteBehavior.Cascade);
        }
    }
}
