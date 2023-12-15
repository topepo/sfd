# accessing designs

    Code
      get_design(1, 5)
    Condition
      Error in `get_design()`:
      ! Number of parameters must be in [2, 15]

---

    Code
      get_design(16, 5)
    Condition
      Error in `get_design()`:
      ! Number of parameters must be in [2, 15]

---

    Code
      get_design(2, 5000)
    Condition
      Error in `get_design()`:
      ! No design with 5000 points. The closest has 500 points.

---

    Code
      get_design(3, 70, type = "max_min_l1")
    Condition
      Error in `get_design()`:
      ! There were no "max_min_l1" designs with 70 design points. Try using `type = 'any'`.

