# setting values

    Code
      update_values(des, p_1)
    Error <rlang_error>
      'values' should be a list.

---

    Code
      update_values(des, list(p_1, p_2, p_3))
    Error <rlang_error>
      The list of values should have 4 elements.

---

    Code
      update_values(des, list(p_1, p_2, p_3, p_4[1]))
    Error <rlang_error>
      Some elements of 'values' do not have 5 values.

