function [p_e,o_e] = end_effector_position_orientation(theta1, theta2, d3, theta4)
% Get parameters
global a1 a2 d1 d4
if (isempty(a1))
    a1 = 0.45;
    a2 = 0.4;
    d1 = 0;
    d4 = -0.06;
end

%syms a1 a2 d1 d3 d4 theta1 theta2 theta4
a     = [a1    ; a2     ;  0  ; 0     ];
alpha = [0     ; 0      ;  0  ; pi    ];
d     = [d1    ; 0      ;  d3 ; d4    ];
theta = [theta1; theta2 ;  0  ; theta4];

%% FK Matrix
%A0_0 = eye(4);
A1_0 = Link_matrix(a(1),alpha(1),d(1),theta(1)) ;
A2_1 = Link_matrix(a(2),alpha(2),d(2),theta(2)) ;
A3_2 = Link_matrix(a(3),alpha(3),d(3),theta(3)) ;
A4_3 = Link_matrix(a(4),alpha(4),d(4),theta(4)) ;

% A2_0=A2_1*A1_0;
% A3_0=A3_2*A2_1*A1_0;
% A4_0=A4_3*A3_2*A2_1*A1_0;   % Teb

A4_0=A1_0*A2_1*A3_2*A4_3;   % Teb

%%
p0 = [0;0;0];
[p_e, o_e] = cal_pose(A4_0,p0);
       