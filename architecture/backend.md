```mermaid

flowchart TB
 subgraph subGraph0["FastAPI Application"]
        App["app.py"]
        Config["config.py"]
        Main["main.py"
  end
 subgraph subGraph1["API Layer number 2"]
        AuthRouter["auth/router.py"]
        FinanceRouter["finance/router.py"]
        StripeRouter["stripe/router.py"]
  end
 subgraph subGraph2["Business Logic"]
        AuthService["auth_service.py"]
        PlaidService["plaid_service.py"]
        FinanceService["finance_service.py"]
  end
 subgraph subGraph3["Data Layer"]
        Repos["repositoriesgfds]/"]
        Models["models/"]
        DB["db.py"]
  end
 subgraph s1["Untitled subgraph"]
        n3["Untitled Node"]
  end
    App --> AuthRouter & FinanceRouter & StripeRouter
    AuthRouter --> AuthService
    FinanceRouter --> FinanceService
    StripeRouter --> PlaidService
    AuthService --> Repos
    FinanceService --> Repos
    PlaidService --> Repos
    Repos --> Models & DB
    subGraph0 --> n1["Untitled Node"] & n2["Untitled Node"]
    n4["Text Block"] --> subGraph0

    n4@{ shape: text}```