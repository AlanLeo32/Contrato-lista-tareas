//SDPX-License-Identifier
pragma solidity 0.8.26;

/**
    *@title Contrato ToDoList
    *@notice Contrato para organizar tareas
    *@author i3arba - 77 Innovation Labs
*/
contract ToDoList {
    ///@notice Estructura para almacenar información de tareas
    struct Task {
        string description; 
        bool completed;
        uint256 timestamp;
    }
    //@notice Evento emitido cuando se añade una nueva tarea
    event ToDoList_TaskCreated(Task task);
    ///@notice Evento emitido cuando una tarea es completada
    event ToDoList_TaskCompleted(Task task);
    ///@notice Evento emitido cuando una tarea es eliminada
    event ToDoList_TaskDeleted(string description,uint256 timestamp);

    Task[] public s_tasks;
    function createTask(string memory _description) external {
        Task memory newTask =Task  ({
            description: _description,
            completed:false,
            timestamp: block.timestamp
        });

        s_tasks.push(newTask);

        emit ToDoList_TaskCreated(newTask);
    }
    function getTask(uint256 _index)external view returns(Task memory _task){
        _task =s_tasks[_index];
        return _task;
    }
    function completeTask(uint256 _index)external {
        s_tasks[_index].completed=true;
        emit ToDoList_TaskCompleted(s_tasks[_index]);
    }
    function deleteTask(string memory _description)external {
        uint256 arrayLength=s_tasks.length;
        for(uint256 i=0;i<arrayLength;i++){
            if(keccak256(abi.encodePacked(s_tasks[i].description) )== keccak256(abi.encodePacked(_description))){
               s_tasks[i]=s_tasks[arrayLength -1];
               s_tasks.pop();
               emit ToDoList_TaskDeleted(_description, block.timestamp);            }
        }
        
    }
}