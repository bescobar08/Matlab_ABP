function lineplot

f=figure;
aH=axes('XLim',[0 1],'Ylim',[0 1]);
h=line([0.5 0.5],[0 1],'color','red','linewidth',3,'ButtonDownFcn',@startDragFcn);
h2=line([0.8 0.8],[0 1],'color','blue','linewidth',3);
set(f,'WindowButtonUpFcn',@stopDragFcn);

 function startDragFcn(varargin)
    set(f,'WindowButtonMotionFcn',@draggingFcn)
 end

function draggingFcn(varargin)
   
    pt=get(aH,'CurrentPoint');
    set(h,'XData',pt(1)*[1 1]);
    set(h2,'XData',(pt(1)+0.2)*[1 1]);
end
    
function stopDragFcn(varargin)

set(f,'WindowButtonMotionFcn','');
end
end