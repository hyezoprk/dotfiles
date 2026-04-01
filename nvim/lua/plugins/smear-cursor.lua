return {
  "sphamba/smear-cursor.nvim",
  event = "VeryLazy",
  opts = {
    smear_between_buffers = true,
    smear_between_neighbor_lines = true,
    scroll_buffer_space = true,
    legacy_computing_symbols_support = true,
    distance_stop_animating_vertical_bar = 0.1,
    stiffness_insert_mode = 0.8,
    trailing_stiffness_insert_mode = 0.8,
    damping_insert_mode = 0.95,
  },
}
