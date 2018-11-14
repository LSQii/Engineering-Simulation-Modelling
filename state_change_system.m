%M为节点数，先定为6，之后修改到4-12
%N为样本数，先定小样本，work后扩大
M = 6; k = 4;
N = 10000;
TA = 77200; TB = 235000;
life = zeros(1,N);
max_time = 78000;

for i = 1: N
    state_system = 0;
    state_node = zeros(1,M);
    main_node = 1;
    state_A = zeros(1,M); state_B = zeros(1,M);
    life_A = exprnd(TA,1,M); life_B = exprnd(TB , 1, M);
    
    while state_system == 0
        A(i) = min(life_A); B(i) = min(life_B); life(i) = min(A(i),B(i));
        if (life(i)==max_time)
            break;
        end
        m = rand;
        if(A(i)<B(i))
            j = find(life_A == life(i),1);
            if(m < 0.14) state_A(j)=1;
            else if (m<0.42) state_A(j) = 2;
                else state_A(j) = 3;
                end
            end
            life_A(j) = max_time;
        else
            j = find(life_B == life(i),1);
            if (m < 0.69) state_B(j) = 1;
            else state_B(j) = 2;
            end
            life_B(j) = max_time;
        end
        
        switch state_A(j)
            case 0 
                if(state_B(j) ==1) state_node(j) = 1;
                else if (state_B(j)==2) state_node(j) = 2;
                     end
                end
            case 1
                if (state_B(j)==1) state_node(j) =5;
                else state_node(j) = 2;
                end
            case 2
                if (state_B(j) == 0) state_node(j) = 3;
                else if (state_B(j) ==1) state_node(j) = 1;
                    else state_node(j) = 4;
                    end
                end
            case 3
                state_node(j) = 4;
        end
        
        p = find(state_node == 0);
        
        if(j == main_node)
            if (state_node(j) ==2 || state_node(j) == 4)
                %找下一个有效节点
                %找到 main_node = k;
                %找不到，system_state = 1;
                if (length(p)>=k) main_node = p(1);
                else state_system = 1;
                end                    
            else if (state_node(j) ==5 )
                    %阻塞总线了，系统直接挂掉
                    state_system = 1;
                end
            end
        else 
            if (state_node(j) == 1 || state_node(j) == 5)
                state_system = 1;
            else if (state_node(j) == 3 || state_node(j) == 4)
                     if (length(p)>=k) main_node = p(1);
                     else state_system = 1;
                     end  
                  end
            end
        end
    end
end

mean_life = mean(life);
fprintf('mean_life = %7.2f\n', mean_life);

                
        

