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
	alignment = 'middle_middle',
	gap_x = 12,
	gap_y = 5,
	no_buffers = true,
	uppercase = false,
	cpu_avg_samples = 2,
	override_utf8_locale = false,

};

conky.text = [[
${color FF9900}${font sans-serif:bold:size=10:}SYSTEM${hr 2}
${color FFFF00}${font sans-serif:normal:size=10}$sysname $kernel $alignr $machine
Host:$alignr$nodename
Uptime:$alignr$uptime
Battery: $alignr${battery_percent BAT0}% (${battery_time BAT0} left)
Processes: $alignr$processes($running_processes running)
Threads: $alignr$threads($running_threads running)
Updates: ${alignr}${execi 10800 pacman -Qu | wc -l}${font} Packages

${font sans-serif:bold:size=10}${color FF9900}PROCESSORS ${hr 2}${font sans-serif:normal:size=10}${color 
FFFF00}
CPU0: ${cpu cpu0}% ${cpubar cpu0}
CPU1: ${cpu cpu1}% ${cpubar cpu1}
CPU2: ${cpu cpu2}% ${cpubar cpu2}
CPU3: ${cpu cpu3}% ${cpubar cpu3}
Load: $loadavg
$loadgraph

${font sans-serif:bold:size=10}${color FF9900}MEMORY ${hr 2}
${font sans-serif:normal:size=10}${color FFFF00}RAM $alignc $mem / $memmax $alignr $memperc%
$membar

${font sans-serif:bold:size=10}${color FF9900}DISKS ${hr 2} 
${font sans-serif:normal:size=10}${color FFFF00}/ $alignc ${fs_used /} / ${fs_size /} $alignr${fs_used_perc /}%
${fs_bar /}

${font sans-serif:bold:size=10}${color FF9900}NETWORK ${hr 2}
${font sans-serif:normal:size=10}${color FFFF00}IP address: $alignr ${addr wlp2s0}
${font sans-serif:normal:size=10}${color FFFF00}Public IP: $alignr${execi 1800 curl http://icanhazip.com/}
ESSID: $alignr ${wireless_essid wlp2s0}
Connection Quality: $alignr ${wireless_link_qual_perc wlp2s0}%

$alignr Download
${downspeedgraph wlp2s0}
${downspeed wlp2s0}/s $alignr ${totaldown wlp2s0}

$alignr Upload
${upspeedgraph wlp2s0}
${upspeed wlp2s0}/s $alignr ${totalup wlp2s0}
]];
