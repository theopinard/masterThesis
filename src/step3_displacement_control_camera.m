clear all
close all
clc

file_path = '../data/camera_control/'
files = dir([file_path '*.tiff']);

for i=1:length(files)
    
    close all
    
    disp(['Image ' num2str(i) ' / ' num2str(length(files))])
    
    I = imread([file_path files(i).name]);
    Ibw2 = rgb2gray(I);
    imshow(Ibw2);
    Ibw = (Ibw2 > 0.4 * max(max(Ibw2)));
    hold on;
    
    
    y = [65, 537] * 4;
    y = [150, 2250]
    for j=150+1:size(Ibw,2)-10
        min_val = max(y(end,2)-30, 1);
        max_val = min(y(end,2) + 30, size(Ibw,1));
        pos = find(Ibw(min_val:max_val,j)==1, 1, 'last');
        if isempty(pos); pos = 0; end;
        y(end+1,:) = [j,  y(end,2)-30+1+pos];
    end
    
    plot(y(:,1), y(:,2), 'ob');
    plot(y(1,1), y(1,2),'or')
    
    
    x = y(1,1); span = 80; count = 1;
    displacement = [];
    while count <= 53
        plot([x x], y(x,2) + span * [-1 1], 'w--');
        text(x , y(x,2) + span, [' ' num2str(count)], 'Color', 'w');
        
        displacement(end+1, :) = [x  y(x-y(1,1)+1, 2)];
        x = x + span;
        count = count + 1;
    end
    
    
   plot(displacement(:,1), displacement(:,2), '*r');
   
   %scale = 10/29;
   scale = 300 / (3291 - 1545);
   displacement(:,1) = displacement(:,1) - displacement(1,1);
   displacement(:,2) = displacement(:,2) - displacement(1,2);
   displacement = displacement * scale;
   
   results(i).case = files(i).name;
   results(i).displacement = displacement;
   results(i).scale = scale;
   results(i).y = y;
   
   h = gcf;
   set(h,'PaperPositionMode','auto');         
   set(h,'PaperOrientation','landscape');
   set(h,'Position',[50 50 1200 800]);

   saveas(gcf, ['../output/camera_control/' files(i).name(1:end-5)], 'jpeg')
    
end

save('../output/back_camera_control_point.mat','results');

