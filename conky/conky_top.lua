conky.config = {
	background = true,
	use_xft = true,
	font = 'Sans:size=10',
	xftalpha = 1,
	update_interval = 1.0,
	total_run_times = 0,
	own_window = true,
	own_window_transparent = true,
	own_window_type = 'desktop',
	own_window_hints = 'undecorated,below,sticky,skip_taskbar,skip_pager',
	double_buffer = true,
	minimum_width = 400, minimum_height = 200,
	maximum_width = 1000,
	draw_shades = true,
	draw_outline = false,
	draw_borders = false,
	draw_graph_borders = true,
	default_color = 'white',
	default_shade_color = 'black',
	default_outline_color = 'white',
	alignment = 'top_right',
	gap_x = 12,
	gap_y = 5,
	no_buffers = true,
	uppercase = false,
	cpu_avg_samples = 2,
	override_utf8_locale = false,

};

conky.text = [[
${font sans-serif:bold:size=10}${color FF9900}TOP PROCESSES by CPU ${hr 2}
${font sans-serif:normal:size=10}${color FFFF00}${top name 1}${alignr}${top cpu 1} %
${top name 2}${alignr}${top cpu 2} %
$font${top name 3}${alignr}${top cpu 3} %
$font${top name 4}${alignr}${top cpu 4} %
$font${top name 5}${alignr}${top cpu 5} %

${font sans-serif:bold:size=10}${color FF9900}TOP PROCESSES by RAM ${hr 2}
${font sans-serif:normal:size=10}${color FFFF00}${top_mem name 1}${alignr}${top mem 1} %
${top_mem name 2}${alignr}${top mem 2} %
$font${top_mem name 3}${alignr}${top mem 3} %
$font${top_mem name 4}${alignr}${top mem 4} %
$font${top_mem name 5}${alignr}${top mem 5} %

${font sans-serif:bold:size=10}${color FF9900}TOP PROCESSES by IO ${hr 2}
${font sans-serif:normal:size=10}${color FFFF00}${top_io name 1}${alignr}${top io_perc 1} %
${top_io name 2}${alignr}${top io_perc 2} %
$font${top_io name 3}${alignr}${top io_perc 3} %
$font${top_io name 4}${alignr}${top io_perc 4} %
$font${top_io name 5}${alignr}${top io_perc 5} %
$font${top_io name 5}${alignr}${top io_perc 5} %

${font sans-serif:bold:size=10}${color FF9900}IO Stat:
${font sans-serif:normal:size=10} $font${exec iostat | sed -n 3,7p}
]];
