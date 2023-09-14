var builder = WebApplication.CreateBuilder(args);

var app = builder.Build();


app.MapGet("/greet", () => {
    return "Hello World";
});

app.Run();


