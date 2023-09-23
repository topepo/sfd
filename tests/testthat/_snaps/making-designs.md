# accessing designs

    Code
      get_design(1, 5)
    Error <rlang_error>
      Number of parameters must be in [2, 10]

---

    Code
      get_design(11, 5)
    Error <rlang_error>
      Number of parameters must be in [2, 10]

---

    Code
      get_design(2, 5000)
    Error <rlang_error>
      No design with 5000 points. The closest has 500 points.

---

    Code
      get_design(3, 69, type = "max_min_l1")
    Error <rlang_error>
      There were no max_min_l1 designs. Try using "type = 'any'"

