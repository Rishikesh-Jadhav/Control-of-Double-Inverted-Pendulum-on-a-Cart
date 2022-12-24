%This is the final project submission for the subject ENPM-667 and group
%members are Rishikesh Jadhav(119256534) and Nishant Pandey(119247556)

function matrix = Observability(C,A)
    
    matrix = rank([C;C*A;C*(A^2);C*(A^3);C*(A^4);C*(A^5)]);
end