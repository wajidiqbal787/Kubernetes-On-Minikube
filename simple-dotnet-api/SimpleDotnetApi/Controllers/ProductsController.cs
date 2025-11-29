using Microsoft.AspNetCore.Mvc;
using System.Collections.Generic;

namespace SimpleDotnetApi.Controllers
{
    [ApiController]
    [Route("[controller]")]
    public class ProductsController : ControllerBase
    {
        [HttpGet]
        public IEnumerable<object> Get()
        {
            return new[] {
                new { id = 1, name = "Product A", price = 100 },
                new { id = 2, name = "Product B", price = 200 }
            };
        }
    }
}
