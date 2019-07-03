const apiCall = () => {
    return new Promise((resolve, reject) => {
        setTimeout(() => {
            resolve(25);
        }, 2000);
    });
}

const getData = async () => { // or: async function getData() { ... }
    const data = await apiCall();
    return data;
}

getData().then(data => {
    document.getElementById('results').textContent = data;
});
