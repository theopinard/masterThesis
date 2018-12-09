% |run the main script to process all the images from both camera and
% compare displacement

run('step1_image_processing_root_camera.m')
run('step2_filter_points_root_camera.m')
run('step3_displacement_control_camera.m')
run('step4_image_processing_control_camera.m')
run('step5_displacement_comparison.m')