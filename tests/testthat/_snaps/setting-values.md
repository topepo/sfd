# setting values

    Code
      update_values(des, p_1)
    Condition
      Error:
      ! `values` should be a list.

---

    Code
      update_values(des, list(p_1, p_2, p_3))
    Condition
      Error:
      ! The list of values should have 4 elements.

---

    Code
      update_values(des, list(p_1, p_2, p_3, p_4[1]))
    Condition
      Error:
      ! Some elements of `values` do not have 5 values.

