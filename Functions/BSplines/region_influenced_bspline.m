function [regAx,regAy,regBx,regBy]=region_influenced_bspline(i,j,O_uniform,sizeI)
%REGION_INFLUENCED_BSPLINE Calculate pixel region influenced by a grid node
%   Detailed explanation goes here


irm=i-2; irp=i+2;
jrm=j-2; jrp=j+2;
irm=max(irm,1); jrm=max(jrm,1);
irp=min(irp,size(O_uniform,1)); jrp=min(jrp,size(O_uniform,2));

regAx=O_uniform(irm,jrm,1); regAy=O_uniform(irm,jrm,2);
regBx=O_uniform(irp,jrp,1); regBy=O_uniform(irp,jrp,2);

if(regAx>regBx), regAxt=regAx; regAx=regBx; regBx=regAxt; end
if(regAy>regBy), regAyt=regAy; regAy=regBy; regBy=regAyt; end

regAx=max(regAx,1); regAy=max(regAy,1);
regBx=max(regBx,1); regBy=max(regBy,1);
regAx=min(regAx,sizeI(1)); regAy=min(regAy,sizeI(2));
regBx=min(regBx,sizeI(1)); regBy=min(regBy,sizeI(2));

end