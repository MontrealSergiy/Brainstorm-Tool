classdef ListOfParameters

    properties (GetAccess = public, SetAccess = protected)
        List cell;        
    end
    
    methods (Access = public)
        
        function obj = ListOfParameters(listOfParameters)
            arguments
                listOfParameters cell = {};
            end
            obj = obj.setList(listOfParameters);
        end

        function obj = setList(obj, listOfObject)
            if isa(listOfObject, class(obj))
                obj = listOfObject;
            elseif isa(listOfObject, 'cell')
                obj.List = listOfObject;
            elseif isscalar(listOfObject)
                obj.List = {listOfObject};
            else
                error('Invalid class');
            end
        end
        
        function obj = add(obj, parameter)
            arguments
                obj
                parameter cell
            end
            obj.List = [obj.List(:), parameter(:)]';
        end
        
        function obj = remove(obj, nameOrIndex)
            index = obj.getParameterIndex(nameOrIndex);
            obj.List(index) = [];
        end
                
        function value = getConvertedValue(obj, nameOrIndex)
            parameter = obj.getParameter(nameOrIndex);
            value = parameter.getConvertedValue();
        end
        
        function value = getValue(obj, nameOrIndex)
            parameter = obj.getParameter(nameOrIndex);
            value = parameter.getValue();
        end
        
        function obj = setValue(obj, nameOrIndex, value)
            index = obj.getParameterIndex(nameOrIndex);
            obj.List{index} = obj.List{index}.setValue(value);
        end
        
        function obj = setValueWithStructure(obj, structure)
            fields = fieldnames(structure);
            for i = 1:length(fields)
                value = structure.(fields{i});
                index = obj.getParameterIndex(fields{i});
                obj = obj.setValue(index, value);
            end
        end
        
        function disp(obj)
            disp(obj.convertToCharacters());
        end
        
        function paramAsChars = convertToCharacters(obj)
            paramAsChars = char(strjoin(obj.convertToStrings(), '\n'));
        end
        
        function isEqual = eq(obj, listOfParameters)
           isEqual = isequal(obj.List, listOfParameters.Parameter);
        end
        
        function json = jsonencode(obj, varargin)
            s = struct();
            for i = 1:obj.getLength()
                param = obj.List{i};
                paramName = param.getName();
                paramValue = param.getValue();
                s.(paramName) = paramValue;                
            end
            json = jsonencode(s, varargin{:});
        end
        
    end
    
    methods (Access = private)
        
        function l = getLength(obj)
           l = length(obj.List); 
        end
        
        function parameter = getParameter(obj, nameOrIndex)
            index = obj.getParameterIndex(nameOrIndex);
            parameter = obj.List{index};
        end
        
        function index = getParameterIndex(obj, input)
            if isnumeric(input)
               index = obj.checkIndex(input);
            elseif ischar(input) || isstring(input)
               index = obj.getParameterIndexWithName(input);
            end
        end
        
        function index = checkIndex(obj, index)
            if index <= 0 || index > obj.getLength()
                error([ 'The parameter index is invalid (' num2str(index) '). ' newline ...
                    'Index should be > 0 and <= ' num2str(obj.getLength()) ': ' newline ...
                    obj.getParameterNames()]);
            end
        end
        
        function index = getParameterIndexWithName(obj, name)
            name = ListOfParameters.formatParameterName(name);
            for index = 1:obj.getLength()
                if strcmpi(name, obj.List{index}.getName())
                    return
                end
            end
            error([ 'The parameter name is invalid (' name '). The parameters are: ' newline ...
                    obj.getParameterNames()]);
        end
        
        function paramAsString = convertToStrings(obj)
            paramAsString = strings(1, obj.getLength());
            for i = 1:length(paramAsString)
                paramAsString(i) = [num2str(i) '. ' obj.List{i}.convertToCharacters()];    
            end
        end
        
        function parameterNames = getParameterNames(obj)
            parametersNames = strings(1, obj.getLength());
            for i = 1:length(parametersNames)
                parametersNames(i) = [num2str(i) '. ' char(obj.List{i}.getName())];
            end
            parameterNames = char(strjoin(parametersNames, '\n'));
        end
        
    end
    
    methods (Static, Access = private)
        
        function paramName = formatParameterName(paramName)
            paramName = Process.formatProcessName(paramName);
        end
        
    end
    
end