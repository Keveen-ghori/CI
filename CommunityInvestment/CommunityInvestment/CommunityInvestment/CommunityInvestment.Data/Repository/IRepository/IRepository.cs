using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace CommunityInvestment.Data.Repository.IRepository
{
    public interface IRepository<City> where City : class
    {
        IEnumerable<City> GetAll();
    }
}
